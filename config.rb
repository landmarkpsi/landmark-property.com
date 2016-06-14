###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end
activate :sprockets

set :css_dir, 'assets/css'

set :js_dir, 'assets/js'

set :images_dir, 'assets/img'

sprockets.append_path 'assets/plugins'

data.portfolio.properties.map(&:region).each do |region|
  proxy "/#{region}", '/region-template.html', locals: {
                        region: region,
                        title: "Apartments in #{region.tr('-', ' ').split.map(&:capitalize).join(' ')}",
                        description: "Find properties in #{region.tr('-', ' ').split.map(&:capitalize).join(' ')} managed by Landmark Property Services, Inc."
                    }, ignore: true
end

data.portfolio.properties.each do |property|
  proxy "/#{property.name.tr(' ', '-').downcase}", '/property-template.html', locals: {
                                                     property: property,
                                                     title: "#{property.name} - #{property.city}",
                                                     description: property.descriptions.join(' '),
                                                     keywords: [property.address, property.neighborhood, property.name]
                                                 }, ignore: true
end

activate :directory_indexes

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  #activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  #activate :asset_hash

  # Use relative URLs
  #activate :relative_assets

  # Or use a different image path
  #set :http_prefix, "/Content/images/"
  activate :gzip
  activate :minify_html

end

  activate :imageoptim do |options|
      options.skip_missing_workers = true
      options.svgo = {}
      options.nice = true
      options.threads = true
      options.verbose = false
      options.image_extensions = %w(.png, .jpg, .gif, .svg)
end


  activate :s3_sync do |s3_sync|
      s3_sync.bucket                     = ENV['AWS_BUCKET'] || 'landmark-property.com'
      s3_sync.region                     = 'us-east-1'
      s3_sync.delete                     = true
      s3_sync.after_build                = true
      s3_sync.prefer_gzip                = false
      s3_sync.path_style                 = true
      s3_sync.reduced_redundancy_storage = false
      s3_sync.acl                        = 'public-read'
      s3_sync.encryption                 = false
      s3_sync.prefix                     = ''
      s3_sync.version_bucket             = false
end

default_caching_policy expires: (Time.now + 60 * 60 * 24 * 365)
