# soapdigi-main
Main framework + landing for SoapDigi Studio

## Development

This site is built using Jekyll and can be run locally using Docker.

### Prerequisites
- Docker
- Docker Compose (optional, for easier development)

### Running locally with Docker Compose

```bash
docker-compose up
```

The site will be available at `http://localhost:4000`

### Running locally with Docker

Build the image:
```bash
docker build -t jekyll-site .
```

Run the container:
```bash
docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll jekyll-site
```

### Deployment

The site is automatically built and deployed to GitHub Pages when changes are pushed to the `main` branch. The deployment is handled by the GitHub Actions workflow in `.github/workflows/jekyll-docker.yml`.
