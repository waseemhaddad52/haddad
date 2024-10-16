# Use an official Node.js image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Create the logs directory
RUN mkdir -p /app/logs

# Expose the port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
