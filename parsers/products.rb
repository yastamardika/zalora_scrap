html = Nokogiri.HTML(content)

product = {}
# p html.css('.l-pageWrapper.l-productPage')
product['name'] = html.css('#product-box .product__brand','#product-box .product__title').text.gsub("\n", "").gsub(/\s+/, " ")
# p product['name'] 
product['brand'] = html.css('#product-box .product__brand').text.gsub(/\s+/,"")
checkDiscount = html.at_css('#product-box #js-detail_specialPrice_without_selectedSize')
product['price'] = html.css('#product-box #js-detail_price_without_selectedSize').text.scan(/[\d+.\d+]+/)[0] if checkDiscount == nil 
product['price'] = checkDiscount.text.scan(/[\d+.\d+]+/)[0] if checkDiscount != nil 
product['is_discount'] = checkDiscount != nil ? true : false
product['discount_price'] = html.css('#product-box #js-detail_specialPrice_without_selectedSize').text.scan(/[\d+.\d+]+/)[0]
# p product['discount_price']
product['number_of_ratings'] = html.at_css('#product-box .review-count') == nil ? 0 : html.css('#product-box .review-count').text 

product['img_url'] = html.css('#product-box #prdZoomBox img > @src').text
# p product['img_url'] 
product['desc'] = html.css('#product-box #productDesc').text.gsub("- ", ", ")
# p product['desc']
product['url'] = page['url']
product['SKU'] = html.css('#product-box .ui-grid.ui-gridFull.product__attr.prd-attributes tbody tr')[0]
product['SKU'] = product['SKU'].css('td')[1].text.gsub(/\s+/,"")
# p product

outputs << product