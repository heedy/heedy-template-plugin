from aiohttp import web
from heedy import Plugin

routes = web.RouteTableDef()

# When starting the plugin server, heedy will send initialization data on STDIN.
# The Plugin object reads this data, and connects with Heedy.
p = Plugin()

# The plugin will answer GET requests at /api/myplugin/hello, returning a simple text response.
# Replace this with your own implementation.
@routes.get(f"/api/{p.name}")
async def hello(request):
    return web.json_response({"hello": "world"})


# Runs the plugin's backend server
app = web.Application()
app.add_routes(routes)
web.run_app(app, path=f"{p.name}.sock")
