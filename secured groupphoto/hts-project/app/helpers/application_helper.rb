module ApplicationHelper

   #lightbox helper
  def lightbox_img_helper(img)
    new_tag = link_to image_tag("#{img.file_name.thumb}"), img.file_name.web.url, :class => 'fancybox', :rel => 'album'
    raw ("#{new_tag}")
  end

  def lightbox_link_helper(text, link)
    new_tag = link_to text, "#{link}/?empty=true", :class => 'fancybox_iframe'
    raw ("#{new_tag}")
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "100 jaar HTS"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  #navigation active button helper
  def is_active?(link_path)
  current_page?(link_path) ? "active" : ""
  end

end
