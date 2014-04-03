#
# Creates site variables that group posts by arbitrary front-matter keys.
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2014 Mark Trapp
# License:: MIT

module Jekyll
  module Itafroma
    class PostGroupsGenerator < Jekyll::Generator
      def generate(site)
        site.config['post_groups'].each do |group|
          key = group['key']
          key_plural = group['key_plural'] || group['key']
          exclude = group['exclude'] || []
          site.config[key_plural] = post_key_hash(site, key, exclude)
        end
      end

      ##
      # Generates a hash using a key from a post's front-matter.
      #
      def post_key_hash(site, post_key, exclude)
        # Build a hash map based on the specified post attribute ( post attr =>
        # array of posts ) then sort each array in reverse order.
        hash = Hash.new { |hsh, key| hsh[key] = Array.new }
        site.pages.each do |p|
          # # Skip post if it doesn't have the correct key
          next unless p.data.key? post_key

          # # Load the value for the key and check if it should be excluded
          t = p.data.fetch(post_key)
          next if exclude.include? t

          # # Add the post to the hash
          hash[t] << p
        end

        # Sort the hash
        hash.values.map { |sortme| sortme.sort! { |a, b|
          if a.data['sort'] && b.data['sort']
            a.data.fetch('sort') <=> b.data.fetch('sort')
          else
            a.data['title'] <=> b.data['title']
          end
        } }
        hash
      end
    end
  end
end
