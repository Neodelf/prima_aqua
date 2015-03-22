module ApplicationHelper
  def price_amount(price)
    if price.start_count.present? && price.end_count.present?
      "#{price.start_count}-#{price.end_count}"
    else
      "от #{price.start_count}"
    end
  end

  def price_val(price)
    if price.value.present?
      price.value.to_s + '<span class="ruble"> Р </span>'
    else
      "Договорная"
    end
  end

  def text_align_for_post(post)
    if post.button_url.blank? && post.button_name.blank? && post.link_url.blank? && post.link_name.blank?
      'center_text_align'
    end
  end
end
