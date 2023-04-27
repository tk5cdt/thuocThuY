let getHompage = (req, res) => {
    return res.render("index.ejs");
}

module.exports = {
    getHompage
}