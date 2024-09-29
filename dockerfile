# Use the official Go image to build the application
FROM golang:1.20-alpine AS build

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod ./
RUN go mod download

# Copy the entire project source code into the container
COPY . .

# Build the Go app
RUN go build -o app .

# Minimal final stage to keep the container small
FROM alpine:latest

# Set the working directory in the final container
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=build /app/app .

# Copy the static folder into the final image
COPY --from=build /app/static ./static

# Expose port 8080 for the web server
EXPOSE 8080

# Run the application
CMD ["./app"]
