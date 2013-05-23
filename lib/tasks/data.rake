namespace :data do
  desc "TODO"
  task :get_10 => :environment do
    flickr.interestingness.getList.first(10).each do |flickr|
      _url = "http://farm#{flickr['farm']}.staticflickr.com/"
      _url += "#{flickr['server']}/#{flickr['id']}_#{flickr['secret']}.jpg"
      photo = Photo.new(remote_image_url: _url, desc: flickr['title'])
      if photo.save
        puts "."
      else
        raise "HELL"
      end
    end
  end

end
