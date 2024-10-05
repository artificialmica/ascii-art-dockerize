# Use the official Go image to build and run the application
FROM golang:1.23

#Our metadata <3
LABEL maintainer="mariambudawas15@gmail.com" \
        maintainer2="khadijahasan198@gmail.com" \
      version="1.0" \
      description="This is a simple Go web server application."

# Install bash using apk (Alpine's package manager)
RUN apk add --no-cache bash


 # Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum, then download dependencies
COPY go.mod ./
RUN go mod download

# Copy the entire project source code into the container
COPY . .

# Build the Go app
RUN go build -o app .

# Expose port 8080 for the web server
EXPOSE 8080

# Run the application
CMD ["./app"]