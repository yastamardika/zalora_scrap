pages << {
    page_type: "listings",
    method: "GET",
    fetch_type: "browser",
    url: "https://www.zalora.co.id/men/sepatu/",
    headers: {
      "User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
      "Sec-CH-UA" => "'Not A;Brand';v='99', 'Chromium';v='96', 'Google Chrome';v='96'"
    },
    vars: {
      category: "Men's shoes",
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