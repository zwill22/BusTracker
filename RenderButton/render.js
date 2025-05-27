const puppeteer = require('puppeteer');

async function init() {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    const htmlContent = `
    <html lang="en">
    <body>
      <script type="text/javascript" src="https://cdnjs.buymeacoffee.com/1.0.0/button.prod.min.js" 
      data-name="bmc-button" data-slug="zmwill" data-color="#FF5F5F" data-emoji="🥤" 
      data-font="Cookie" data-text="Buy me a Cherry Cola" data-outline-color="#000000"
      data-font-color="#ffffff" data-coffee-color="#FFDD00" ></script>
    </body>
    </html>
`;
    await page.setContent(htmlContent);
    await page.screenshot({
        path: 'image.png',
        fullPage: false,
        omitBackground: true
    });
    await browser.close();
}

init();
