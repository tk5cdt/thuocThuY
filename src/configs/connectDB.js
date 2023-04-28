const sql = require('tedious');
const config = {
    server: 'Truong.database.windows.net',
    authentication: {
        type: 'default',
        options: {
            userName: 'your_username',
            password: 'your_password'
        }
    },
    options: {
        database: 'QL_NHATHUOCTHUY',
        encrypt: true
    }
};

const connection = new sql.Connection(config);
connection.on('connect', function(err) {
    if (err) {
        console.log(err);
    } else {
        console.log('Connected');
    }
});