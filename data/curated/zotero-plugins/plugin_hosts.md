|variable      |class     |description |
|:-------------|:---------|:-----------|
|slug          |character |Id of the plugin; joins zotero_plugins. |
|host          |character |A web address (host name) the plugin's code contacts or names, for example api.openai.com. 127.0.0.1 and localhost are the user's own computer. |
|host_category |character |What kind of service the host is: llm-provider (AI services), translation, scholarly-api (scholarly services such as Crossref), zotero, integration (apps the user connects), code-hosting, cdn, documentation, telemetry (analytics and tracking), cloud-function, developer-server (the plugin developer's own servers), localhost (the user's own computer), unknown (not identified). |
|confirmed     |logical   |TRUE if the site traced a request to this host in the code or saw one when it ran the plugin; FALSE if the host is only named in the code. |
