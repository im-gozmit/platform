json.identifier  params[:id]
json.content @message
json.uninstalled true if @progress == 0