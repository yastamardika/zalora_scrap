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
      "code": "
      await page.evaluate(()=> {
        
        const wait = (duration) => { 
          console.log('waiting', duration);
          return new Promise(resolve => setTimeout(resolve, duration)); 
        };
    
        (async () => {
          
          window.atBottom = false;
          const scroller = document.documentElement;  // usually what you want to scroll, but not always
          let lastPosition = -1;
          while(!window.atBottom) {
            scroller.scrollTop += 1000;
            // scrolling down all at once has pitfalls on some sites: scroller.scrollTop = scroller.scrollHeight;
            await wait(300);
            const currentPosition = scroller.scrollTop;
            if (currentPosition > lastPosition) {
              console.log('currentPosition', currentPosition);
              lastPosition = currentPosition;
            }
            else {
              window.atBottom = true;
            }
          }
          console.log('Done!');
    
        })();
    
      });
    
      await page.waitForFunction('window.atBottom == true', {
        timeout: 900000,
        polling: 1000 // poll for finish every second
      });"
    }
  }