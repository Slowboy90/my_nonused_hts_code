module ApplicationHelper
  def lightbox_img_helper(img)
    new_tag = link_to image_tag("#{img.file_name.thumb}"), img.file_name.web.url, :class => 'fancybox', :rel => 'album'
    raw ("#{new_tag}")
  end
  def lightbox_link_helper(text, link)
    new_tag = link_to text, "#{link}/?empty=true", :class => 'fancybox_iframe'
    raw ("#{new_tag}")
  end

  def full_title(page_title = '')
  	base_title = '100 jaar hts reunie'
  	if page_title.empty?
  		base_title
  	else
  		"#{page_title} | #{base_title}"
  	end
  end

  def current_link_to path
    (current_page?(path) ? "active" : nil)
  end
end
