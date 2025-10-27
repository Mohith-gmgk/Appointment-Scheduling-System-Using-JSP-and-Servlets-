# Base image with Java runtime environment
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Define the required application runner (Tomcat substitute)
ENV WEBAPP_RUNNER_VERSION 9.0.52.1
ENV PORT 8080

# Download the webapp-runner (Tomcat wrapper) JAR
RUN wget --quiet https://repo1.maven.org/maven2/com/heroku/sdk/webapp-runner/$WEBAPP_RUNNER_VERSION/webapp-runner-$WEBAPP_RUNNER_VERSION.jar -O webapp-runner.jar

# Copy your project's WAR file into the container
COPY AppointmentScheduler.war AppointmentScheduler.war

# Set the command to run the application when the container starts
CMD java $JAVA_OPTS -jar webapp-runner.jar --port $PORT AppointmentScheduler.war