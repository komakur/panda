const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const WebSocket = require('ws');
const crypto = require('crypto');

const app = express();
const PORT = 3000;
const WS_PORT = 8080;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Simple in-memory "user database"
const validUsers = { user1: null, user2: null }; // Users with no token initially

// Generate a unique token
function generateAuthToken() {
    return crypto.randomBytes(16).toString('hex'); // 16-byte token in hex format
}

// Login endpoint (updated to include 'auth/' prefix)

app.post('/auth/login', (req, res) => {
    const { username } = req.body;

    console.log(username);

    if (validUsers.hasOwnProperty(username)) {
        const token = generateAuthToken(); // Generate a unique token
        validUsers[username] = token; // Store the token for the user
        res.json({
            success: true,
            username: username, // Include the username in the response
            token,    // Include the token in the response
        });
    } else {
        res.status(401).json({
            success: false,
            text: 'Invalid username',
        });
    }
});


// Start Express server
app.listen(PORT, () => {
    console.log(`Auth server running on http://localhost:${PORT}`);
});

// WebSocket Server
const wsServer = new WebSocket.Server({ port: WS_PORT });

const clients = new Map(); // Map WebSocket connections to usernames

wsServer.on('connection', (ws) => {
    console.log('New client connected');

    ws.on('message', (data) => {
        const parsedData = JSON.parse(data);
        console.log(parsedData);

        if (parsedData.type === 'register') {
            const { sender, token } = parsedData;
            const username = sender;

            console.log('in register');
            console.log(username);
            console.log(token);


            // Validate the token
            if (validUsers[username] === token) {
                clients.set(ws, username); // Associate the WebSocket with the username
                console.log(`${username} registered.`);
                ws.send(JSON.stringify({ success: true, text: 'Registration successful' }));
            } else {
                ws.send(JSON.stringify({ success: false, text: 'Invalid token' }));
            }
        } else if (parsedData.type === 'message') {
            // Handle chat message and broadcast it
            const sender = clients.get(ws) || 'Anonymous'; // Get the username, default to 'Anonymous' if not found
            const messagePayload = {
                sender: sender,
                text: parsedData.text,
                sentAt: new Date().toISOString(),
                type: "message",
            };

            console.log(messagePayload);

            // Broadcast message to all connected clients
            for (const client of clients.keys()) {
                if (client.readyState === WebSocket.OPEN) {
                    client.send(JSON.stringify(messagePayload));
                }
            }
        }
    });

    ws.on('close', () => {
        console.log('Client disconnected');
        clients.delete(ws); // Remove client when they disconnect
    });
});

console.log(`WebSocket server running on ws://localhost:${WS_PORT}`);
