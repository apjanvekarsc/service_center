# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
#Rails.application.config.assets.precompile += %w( 123.js )
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( 123.js )
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( inw/*.png)
Rails.application.config.assets.precompile += %w( ft/*.png )
Rails.application.config.assets.precompile += %w( sc/*.png )
Rails.application.config.assets.precompile += %w( ecol/*.png )

Rails.application.config.assets.precompile += %w( obdx/*.png )
Rails.application.config.assets.precompile += %w( sm/*.png )
Rails.application.config.assets.precompile += %w( rc/*.png )
Rails.application.config.assets.precompile += %w( rr/*.png )
Rails.application.config.assets.precompile += %w( datapurge/*.png )
Rails.application.config.assets.precompile += %w( pc/*.png )
Rails.application.config.assets.precompile += %w( ns/*.png )
Rails.application.config.assets.precompile += %w( rp/*.png )
Rails.application.config.assets.precompile += %w( icol/*.png )









# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
 Rails.application.config.assets.precompile += %w( admin.js admin.css )
