FROM golang:1.20-alpine AS build

WORKDIR /app 


#COPY go.mod .
#COPY main.go .
#this is how you can make a comment btw

RUN go mod download.

COPY . .

# Build the Go app and output a binary called 'app'
RUN go build -o app .

# Minimal final stage to keep the container small
FROM alpine:latest

# Set the working directory in the final container
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=build /app/app .

# Expose port 8080 for the web server
EXPOSE 8088

# Run the application
CMD ["./app"]