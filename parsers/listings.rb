html = Nokogiri.HTML(content)

#load products
# p html.css('body')
products = html.css('.b-catalogList__wrapper.clearfix li')
p products.length 
products.each do |product|
    link = product.css('.b-catalogList__itmLink.itm-link > @href').text
    url = URI.join('https://zalora.co.id', link).to_s.split('?').first
    # p url
    if product
        if url =~ /\Ahttps?:\/\//i
        pages << {
            url: url,
            page_type: 'products',
            fetch_type: 'browser',
            force_fetch: true,
            vars: {
            category: page['vars']['category'],
            url: url
            }
        }
        end
    end
end