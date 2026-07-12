var iframe = document.getElementById("embeddedIframe");
var iframeDocument = iframe.contentDocument;
var checkbox_closed = iframeDocument.getElementById("closed");
checkbox_closed.click();
var checkbox_archived = iframeDocument.getElementById("archived");
checkbox_archived.click();

var link = iframeDocument.querySelector('a[title="Click to export detailed data"]');

setTimeout(() => {
  link.click();
}, "10000");
