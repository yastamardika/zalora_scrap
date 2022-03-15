html = Nokogiri.HTML(content)

all_products = JSON.parse(html)
products = all_products['response']['docs']
p products.length
products.each do |product|
    url = URI.join('https://zalora.co.id', product['link']).to_s.split('?').first
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

current_offset = page['vars']['current_offset']
if current_offset <= all_products['response']['numFound']
    current_offset += 180
    pages << {
        page_type: "listings",
        method: "GET",
        fetch_type: "browser",
        url: "https://www.zalora.co.id/_c/v1/rr/desktop/list_catalog_products?url=%2Fmen%2Fsepatu&sort=popularity&dir=desc&offset=#{current_offset}&limit=180&category_id=27&gender=men&segment=men&special_price=false&all_products=false&new_products=false&top_sellers=false&catalogtype=Main&lang=id&is_brunei=false&sort_formula=sum(product(0.1%2Cscore_simple_availability)%2Cproduct(0.0%2Cscore_novelty)%2Cproduct(0.9%2Cscore_product_boost)%2Cproduct(0.0%2Cscore_random)%2Cproduct(1.0%2Cscore_personalization))&search_suggest=false&enable_visual_sort=true&enable_filter_ads=true&compact_catalog_desktop=false&name_search=false&solr7_support=false&pick_for_you=false&learn_to_sort_catalog=false&enable_similar_term=true&enable_relevance_classifier=true&auto_correct=true",
        headers: {
          "User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
          "Sec-CH-UA" => "'Not A;Brand';v='99', 'Chromium';v='96', 'Google Chrome';v='96'"
        },
        vars: {
          category: "Men's shoes",
          current_offset: current_offset
        },
        driver: {
          "pre_code": "
            let lastHeight = await page.evaluate('document.body.scrollHeight');   
            while (true) {
                await page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
                await page.waitForTimeout(2000); // sleep a bit
                let newHeight = await page.evaluate('document.body.scrollHeight');
                if (newHeight === lastHeight) {
                    break;
                }
                lastHeight = newHeight;
            }"
        }
    }
end