import Hello from "./main/hello.vue";


function setup(frontend) {

    // Conditionally initialize features depending on whether user is logged in.
    if (frontend.info.user !== null) {

        // Add the given page to the frontend's URL routes
        frontend.addRoute({
            path: "/myplugin",
            component: Hello
        });

        // Add a main menu item linking to the page
        frontend.addMenuItem({
            key: "mypluginMenuItem",
            text: "My Plugin Page",
            icon: "fas fa-hand-sparkles",
            route: "/myplugin"
        });
    }



}

export default setup;