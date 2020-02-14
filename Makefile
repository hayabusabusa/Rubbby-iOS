.PHONY: inject-app-id

inject-app-id:
	echo "let appID = \"${APP_ID}\"" > ./Rubbby/Secrets.swift