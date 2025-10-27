# Base image with Java runtime environment
# openjdk:17-jdk-slim is based on Debian/Ubuntu, so we use apt-get
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Define the required application runner (Tomcat substitute)
ENV WEBAPP_RUNNER_VERSION 9.0.52.1
# NOTE: Removed ENV PORT 8080 as Render provides this

# 🔑 FIX: Install curl before attempting to download
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/* # Download the webapp-runner (Tomcat wrapper) JAR
# Using curl instead of wget, and using the defined ENV variable
RUN curl -sL https://repo1.maven.org/maven2/com/heroku/sdk/webapp-runner/$WEBAPP_RUNNER_VERSION/webapp-runner-$WEBAPP_RUNNER_VERSION.jar -o webapp-runner.jar

# Copy your project's WAR file into the container
COPY AppointmentScheduler.war AppointmentScheduler.war

# Set the command to run the application when the container starts
CMD java $JAVA_OPTS -jar webapp-runner.jar --port $PORT AppointmentScheduler.war