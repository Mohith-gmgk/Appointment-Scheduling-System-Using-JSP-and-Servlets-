# Stage 1: Base image for running the application
# Use the openjdk-jre-slim for a smaller final image if you don't need the JDK runtime tools
FROM openjdk:17-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Define the required application runner (Tomcat wrapper) version
# (NOTE: Replace with the actual latest version)
ENV WEBAPP_RUNNER_VERSION 9.0.87.0 

# Download the webapp-runner (Tomcat wrapper) JAR
# Use curl and an explicit check for a cleaner, more robust download
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://repo1.maven.org/maven2/com/heroku/sdk/webapp-runner/$WEBAPP_RUNNER_VERSION/webapp-runner-$WEBAPP_RUNNER_VERSION.jar -o webapp-runner.jar

# Remove curl after use to reduce image size (optional but recommended)
RUN apt-get remove --purge -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your project's WAR file into the container
# NOTE: Ensure 'AppointmentScheduler.war' is in the same directory as this Dockerfile
COPY AppointmentScheduler.war AppointmentScheduler.war

# Expose the port (Render will use its own environment variable, but this is good practice)
EXPOSE 8080

# Set the command to run the application when the container starts
# The array (exec) form is used. 
# It correctly uses the $PORT environment variable, which Render sets.
ENTRYPOINT ["java", "-jar", "webapp-runner.jar", "--port", "$PORT", "/app/AppointmentScheduler.war"]