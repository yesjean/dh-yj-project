const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const session = require('express-session');
const bcrypt = require('bcrypt');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 1113;
app.use(cors()); // CORS 설정 추가
// SQLite 데이터베이스 연결
const db = new sqlite3.Database('database.db');

// 테이블 생성
db.serialize(() => {
    // db.run(`DROP TABLE IF EXISTS users`);
    // db.run(`CREATE TABLE users (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     name TEXT,
    //     email TEXT,
    //     password TEXT
    // )`);
    db.run(`CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT
    )`);
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 세션 설정
app.use(session({
    secret: 'your-secret-key', // 세션 암호화에 사용될 비밀키
    resave: false, // 세션을 요청 처리할 때마다 세션을 다시 저장할지 여부
    saveUninitialized: false // 초기화되지 않은 세션도 저장할지 여부
}));

app.use(express.static(path.join(__dirname, 'public')));

// 사용자 목록 조회
app.get('/users', (req, res) => {
    db.all('SELECT id, name, email FROM users', (err, rows) => {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(rows);
    });
});

// 사용자 생성
app.post('/users', (req, res) => {
    const { name, email } = req.body;
    db.run('INSERT INTO users (name, email) VALUES (?, ?)', [name, email], function(err) {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ id: this.lastID });
    });
});

// 사용자 삭제
app.delete('/users/:id', (req, res) => {
    const { id } = req.params;
    db.run('DELETE FROM users WHERE id = ?', id, function(err) {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ deletedID: id });
    });
});

// 사용자 수정
app.put('/users/:id', (req, res) => {
    const { id } = req.params;
    const { name, email } = req.body;
    db.run('UPDATE users SET name = ?, email = ? WHERE id = ?', [name, email, id], function(err) {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ updatedID: id });
    });
});

// 회원가입
app.post('/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const hashedPassword = await bcrypt.hash(password, 10);

        db.run('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', [name, email, hashedPassword], function(err) {
            if (err) {
                console.error(err.message);  // 에러 로그 출력
                res.status(500).json({ error: err.message });
                return;
            }
            res.json({ id: this.lastID });
        });
    } catch (error) {
        console.error(error);  // 에러 로그 출력
        res.status(500).json({ error: error.message });
    }
});

// 로그인
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    db.get('SELECT * FROM users WHERE email = ?', [email], async (err, user) => {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }

        if (!user) {
            res.status(401).json({ error: 'Invalid email or password' });
            return;
        }

        const match = await bcrypt.compare(password, user.password);
        if (match) {
            req.session.userId = user.id;
            res.json({ message: 'Login successful' });
        } else {
            res.status(401).json({ error: 'Invalid email or password' });
        }
    });
});
// 로그인 처리 라우트
app.post('/login', (req, res) => {
    // 사용자 인증 후 세션에 사용자 정보 저장
    req.session.user = { username: 'exampleuser' }; // 예시로 사용자 정보를 객체로 저장
    res.send('Login successful');
});

// 로그아웃
app.post('/logout', (req, res) => {
    req.session.destroy(err => {
        if (err) {
            console.error(err.message);  // 에러 로그 출력
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ message: 'Logout successful' });
    });
});

// 특정 라우트에서 로그인 상태 확인
app.get('/protected', (req, res) => {
    if (req.session.user) {
        // 사용자가 로그인한 경우
        res.send('You are logged in');
    } else {
        // 사용자가 로그인하지 않은 경우
        res.send('You are not logged in');
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
