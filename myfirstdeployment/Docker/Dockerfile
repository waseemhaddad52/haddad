# Use an official Node.js image from DockerHub
FROM node:14

# Create and set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Command to start the app
CMD ["npm", "start"]
