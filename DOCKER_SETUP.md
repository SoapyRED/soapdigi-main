# Jekyll Docker Setup Documentation

## Overview

This repository is configured to build and deploy a Jekyll site using Docker. The setup includes:

1. **Jekyll Configuration** (`_config.yml`) - Main Jekyll configuration
2. **Gemfile** - Ruby dependencies for Jekyll
3. **Dockerfile** - Docker image definition for building the Jekyll site
4. **docker-compose.yml** - Docker Compose configuration for local development
5. **GitHub Actions Workflow** (`.github/workflows/jekyll-docker.yml`) - Automated build and deployment

## File Structure

```
.
├── .github/
│   └── workflows/
│       └── jekyll-docker.yml    # CI/CD workflow
├── _layouts/
│   └── default.html             # Default page layout
├── _config.yml                  # Jekyll configuration
├── Dockerfile                   # Docker build instructions
├── docker-compose.yml           # Local development setup
├── Gemfile                      # Ruby dependencies
├── index.html                   # Main landing page
└── README.md                    # Project documentation
```

## Local Development

### Using Docker Compose (Recommended)

The easiest way to run the site locally is with Docker Compose:

```bash
docker-compose up
```

This will:
- Build the Docker image
- Install Jekyll dependencies
- Start the Jekyll server with live reload
- Make the site available at http://localhost:4000

To stop the server, press `Ctrl+C` or run:
```bash
docker-compose down
```

### Using Docker Directly

Build the image:
```bash
docker build -t jekyll-site .
```

Run the container:
```bash
docker run --rm -p 4000:4000 -v $(pwd):/srv/jekyll jekyll-site
```

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the `main` branch.

### GitHub Actions Workflow

The workflow (`.github/workflows/jekyll-docker.yml`) performs the following steps:

1. **Build Job**:
   - Checks out the repository
   - Sets up Docker Buildx
   - Builds the Jekyll site using Docker
   - Uploads the built site as an artifact

2. **Deploy Job** (only on main branch):
   - Downloads the built site artifact
   - Deploys to GitHub Pages

### Required GitHub Settings

For the deployment to work, ensure the following settings are configured in your GitHub repository:

1. Go to **Settings** → **Pages**
2. Set **Source** to "GitHub Actions"
3. The workflow will automatically deploy to GitHub Pages

## Customization

### Changing Site Content

- Edit `index.html` to change the home page content
- Edit `_config.yml` to change site title, description, and other settings
- Add new pages by creating new `.html` or `.md` files in the root directory
- Customize the layout by editing `_layouts/default.html`

### Modifying the Build Process

- **Dockerfile**: Edit to change the Jekyll version or add custom build steps
- **Gemfile**: Add or update Ruby gems/Jekyll plugins
- **docker-compose.yml**: Modify for different local development configurations

## Troubleshooting

### Port Already in Use

If port 4000 is already in use, you can change it in `docker-compose.yml`:

```yaml
ports:
  - "4001:4000"  # Change 4001 to any available port
```

### Bundle Install Failures

If you encounter bundle install errors, try rebuilding the Docker image from scratch:

```bash
docker-compose build --no-cache
```

### Live Reload Not Working

The docker-compose configuration includes `--livereload` and `--force_polling` flags to enable live reload. If it's still not working, try:

1. Ensure your browser allows the WebSocket connection
2. Refresh the page manually after making changes

## Testing

A validation script is available to test the Jekyll structure:

```bash
python3 /tmp/test-jekyll-structure.py
```

This validates:
- All required files exist
- YAML files are valid
- File contents contain expected elements
