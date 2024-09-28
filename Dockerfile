FROM dart:stable AS build

# Work Directory
WORKDIR /app

# Resolve app dependencies.
COPY pubspec.* ./

# Install the Vania cli from pub.dev
RUN dart pub global activate vania_cli

# Get dependencies
RUN dart pub get

# Copy app source code and build
COPY . .

# Build production app
RUN dart pub get --offline
RUN vania migrate
RUN vania build && ls -la /app/bin  # Add this line to check the output

# Build minimal serving image
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /bin/server
COPY --from=build /app/.env /
COPY --from=build /app/public /public/
COPY --from=build /app/storage /storage/

# Expose server port
EXPOSE 8000
CMD ["/bin/server"]
