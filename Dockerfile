# Use official Jekyll image
FROM jekyll/jekyll:4.2.2

# Set working directory
WORKDIR /srv/jekyll

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install dependencies
RUN bundle install

# Copy the rest of the site
COPY . .

# Expose port for serving
EXPOSE 4000

# Command to serve the site (build happens on serve)
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
