CREATE TABLE todos (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        name       TEXT ,
        comment    TEXT ,
        created_at      TIMESTAMP default current_timestamp,
        updated_at      TIMESTAMP default current_timestamp,
        deadline        DATETIME
);

INSERT INTO todos (name, comment) values ("testName", "testComment");
INSERT INTO todos (name, comment, deadline) VALUES ('パーティの返事をする', '鹿鳴館', datetime('now', '+1 days'));
INSERT INTO todos(name, comment) VALUES ('年金の書類を提出する', '両親に確認を取る');
INSERT INTO todos(name, comment, deadline) VALUES ('内定式', 'スピーチの練習をしておく', datetime('now', '+1 days'));
INSERT INTO todos(name, comment, deadline) VALUES ('澄川さんへのメッセージを書く', 'ありがとうございました！', datetime('now'));
INSERT INTO todos(name, comment, deadline) VALUES ('借りた本を返す', '', datetime('now', '-1 days'));
INSERT INTO todos(name, comment) VALUES ('Perlマスターになる', 'Rubyiestを駆逐してやる');
