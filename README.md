# Docker registry with HTTP authentication

A Docker Registry v3 image with built-in HTTP basic authentication using htpasswd.

## Overview

This project provides a ready-to-use Docker image that extends the official Docker Registry (version 3) with HTTP basic authentication. It automatically configures htpasswd-based authentication using environment variables, making it easy to deploy a secure, private Docker registry.

## Features

- Based on the official Docker Registry v3
- Automatic htpasswd authentication configuration
- Simple setup via environment variables
- Minimal dependencies (only adds apache2-utils for htpasswd)

## Usage

### Running the Registry locally

```shellsession
user@local $ docker run -d \
  -p 5000:5000 \
  -e REGISTRY_USER=myuser \
  -e REGISTRY_PASSWORD=mypassword \
  --name registry \
  mittwald/registry:3
```

### Running the Registry on the mittwald cloud

```shellsession
user@local $ mw container run \
  -p 5000:5000 \
  -e REGISTRY_USER=myuser \
  -e REGISTRY_PASSWORD=mypassword \
  --name registry \
  mittwald/registry:3
```

### Required Environment Variables

- `REGISTRY_USER`: The username for registry authentication
- `REGISTRY_PASSWORD`: The password for registry authentication

### Optional Environment Variables

- `REGISTRY_AUTH_HTPASSWD_REALM`: The realm name for authentication (default: "Registry Realm")

All standard Docker Registry environment variables are also supported. See the [official Docker Registry documentation](https://docs.docker.com/registry/configuration/) for more options.

### Pushing and Pulling Images

Once the registry is running with authentication, you'll need to log in before pushing or pulling images. The examples assume your registry is running in the mittwald cloud, and that you have connected your registry container to a subdomain of the default `p-XXXXXX.project.space` subdomain.

```bash
# Log in to the registry
docker login registry.p-XXXXXX.project.space

# Tag an image
docker tag myimage:latest registry.p-XXXXXX.project.space/myimage:latest

# Push the image
docker push registry.p-XXXXXX.project.space/myimage:latest

# Pull the image
docker pull registry.p-XXXXXX.project.space/myimage:latest
```

## Building

To build the image yourself:

```bash
docker build -t mittwald/registry:3 .
```

## How It Works

The `auth-entrypoint.sh` script:

1. Validates that `REGISTRY_USER` and `REGISTRY_PASSWORD` are set
2. Generates an htpasswd file with the provided credentials
3. Sets the necessary registry authentication environment variables
4. Passes control to the standard registry entrypoint

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
