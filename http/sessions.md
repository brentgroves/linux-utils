https://www.section.io/engineering-education/session-management-in-nodejs-using-expressjs-and-express-session/


app.get('/',(req,res) => {
    session=req.session;
    if(session.userid){
        res.send("Welcome User <a href=\'/logout'>click to logout</a>");
    }else
    res.sendFile('views/index.html',{root:__dirname})
});