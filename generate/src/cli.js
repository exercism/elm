// Get slug as argument
const slug = process.argv[2];

// Get data from stdin and write files
var fs = require("fs");
var data = fs.readFileSync(0, "utf-8"); // 0 is stdin

// Link to compiled Elm code main.js and run it
var Elm = require("./main").Elm;
var flags = { slug: slug, data: JSON.parse(data) };
var main = Elm.Main.init({ flags: flags });

// Get data from the elm app
main.ports.stdout.subscribe(files => {
    files.forEach(file => {
        // Write files generated by Elm
        console.log("Writing file " + file.path);
        fs.writeFile(file.path, file.file, err => {
            if (err) {
                console.error(err);
                return;
            }
        });
    });
});