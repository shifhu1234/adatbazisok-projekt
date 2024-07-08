const mysql = require("mysql");
const bcrypt = require("bcrypt");
const express = require("express");
const salt = 10;
const path = require('path');

module.exports = (app) => {
    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "konferencia_db"
    });

    app.get('/main', (req, res, next) => {
        res.redirect('/');
        next();
    });

    app.get('/profilee', (req, res, next) => {
        res.render('profile');
        next();
    });

    app.get('/profile-auth', (req, res, next) => {
        if (req.session.user) {
            res.redirect('/profilee');

        } else {
            console.log("Nincs session!");
            res.redirect('/');

        }
        next();
    });

    app.get('/login-view', (req, res, next) => {
        res.render('login', {registered: registered, unRegistered: unRegistered});
        next();
    });

    app.get('/profile', function (req, res) {
        const user = req.session.user;
        res.render('profile.ejs', {user});
    });

    var unRegistered = false;
    app.post('/register', function (req, res) {
        const reg_name = req.body.reg_name;
        const reg_password = req.body.reg_password;
        const reg_password_repeat = req.body.reg_password_repeat;
        const reg_email = req.body.reg_email;
        const prefix = null;
        const role = 'szerzo';
        const institution = null;
        registered = false;
        unRegistered = true;

        if (reg_password.length < 6 || reg_password !== reg_password_repeat) {
            console.error('Jelszavaknak legalább 6 karakter hosszúnak kell lennie');
            res.redirect('/login-view');
        }else{

        bcrypt.hash(req.body.reg_password, salt, (err, hash) => {
            if (err) {
                //console.log(err);
                res.redirect('/login-view');
            } else {
                connection.query('SELECT id FROM users WHERE email = ?', [reg_email], function (error, results) {
                    if (error) {
                        console.error('MySQL hiba: ', error);
                        res.redirect('/login-view');
                    } else if (results.length > 0) {
                    } else {
                        connection.query('SELECT id FROM users WHERE name = ?', [reg_name], function (error, results) {
                            if (error) {
                                console.error('MySQL hiba: ', error);
                                res.redirect('/login-view');
                            } else if (results.length > 0) {
                                res.redirect('/login-view');
                            } else {
                                const query = 'INSERT INTO users (id, name, password, email, role, prefix, institution) VALUES (NULL, ?, ?, ?, ?, ?, ?)';
                                connection.query(query, [reg_name, hash, reg_email, role, prefix, institution], function (error, results) {
                                    if (error) {
                                        console.error('MySQL hiba: ', error);
                                        res.redirect('/login-view');
                                    }
                                    registered = true;
                                    res.redirect('/login-view');
                                });
                            }
                        });
                    }
                });
            }
        });}
    });

    app.post('/change-prefix', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }

        const prefix = req.body.prefix;
        const userId = req.body.userId;

        if (prefix) {
            connection.query('UPDATE users SET prefix = ? WHERE id = ?', [prefix, userId], (error, results) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk módosítása során.');
                }
            });
        } else {
            connection.query('UPDATE users SET prefix = NULL WHERE id = ?', [userId], (error, results) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk módosítása során.');
                }
            });
        }
        res.redirect('/profile');
    });

    app.post('/change-institution', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }

        const institution = req.body.institution;
        const userId = req.body.userId;

        if (institution) {
            connection.query('UPDATE users SET institution = ? WHERE id = ?', [institution, userId], (error, results) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk módosítása során.');
                }
            });
        } else {
            connection.query('UPDATE users SET institution = NULL WHERE id = ?', [userId], (error, results) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk módosítása során.');
                }
            });
        }
        res.redirect('/profile');
    });


    app.post('/login', function (req, res) {
        const email = req.body.email;
        const password = req.body.password;

        connection.query('SELECT * FROM users WHERE email = ? OR name = ?', [email, email], function (error, results) {
            if (error) {
                console.error('MySQL hiba: ', error);
                res.status(500).send('Hiba történt a bejelentkezés során.');
            } else if (results.length === 0) {
                res.status(401).send('Nem létező e-mail cím vagy hibás jelszó.');
            } else {
                const user = results[0];
                bcrypt.compare(password, user.password, (err, result) => {
                    if (err) {
                        console.log(err);
                        res.status(500).send('Hiba történt a bejelentkezés során.');
                    } else if (result) {
                        req.session.user = {
                            email: user.email,
                            name: user.name,
                            prefix: user.prefix,
                            institution: user.institution,
                            password: user.password,
                            id: user.id,
                            role: user.role,
                            popUpShown: false
                        };

                        req.session.cookie.maxAge = 3600000;
                        //console.log(req.session);

                        res.redirect('/profile');
                    } else {
                        res.status(401).send('Nem létező e-mail cím vagy hibás jelszó.');
                    }
                });
            }
        });
    });
    app.get('/logout-button', (req, res) => {
        registered = false;
        req.session.destroy();
        res.redirect('/?fromLogoutButton=true');

    });

    app.post('/give-admin', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }
        const name = req.body.maybeAdminUserId;
        const admin = 'admin';
        connection.query('UPDATE users SET role = ? WHERE name = ? ',[admin, name], (error, results)=>{
            if (error) {
                console.error('MySQL hiba: ', error);
                return res.status(500).send('Hiba történt a cikk módosítása során.');
            }
        })
        res.redirect('/main');

    })
    app.post('/modify-article', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }

        const sectionId = req.body.conductor;
        const title = req.body.articletitle;

        if (sectionId === '0') {
            connection.query('UPDATE articles SET section_id = NULL WHERE title = ?', [title], (error, results) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk módosítása során.');
                }
                res.redirect('/main');
            });
        } else {
            res.redirect('/main');
        }
    });


    app.post('/submit-article', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }
        const userId = req.session.user.id;
        const title = req.body.articletitle;

        const sectionName = req.body.sectionId;

        if (sectionName === 'no_section') {
            connection.query('SELECT id FROM article WHERE title = ?', [title], function (error, results) {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    return res.status(500).send('Hiba történt a cikk beküldése során.');
                } else if (results.length > 0) {
                    res.send('Article name is already taken.');
                } else {
                    connection.query('INSERT INTO article (id, users_id, title) VALUES (NULL, ?, ?)', [userId, title], (error, results) => {
                        if (error) {
                            console.error('MySQL hiba: ', error);
                            return res.status(500).send('Hiba történt a cikk beküldése során.');
                        }else{
                            connection.query('SELECT id FROM article WHERE title = ?', [title], (error, results) =>{
                                if (error) {
                                    console.error('MySQL hiba: ', error);
                                    return res.status(500).send('Hiba történt a cikk beküldése során.');
                                }else{
                                    const articleId = results[0].id;
                                connection.query('INSERT INTO conference (id, users_id, article_id) VALUES(NULL, ?, ?)', [userId, articleId], (error, results) =>{
                                    if (error) {
                                        console.error('MySQL hiba: ', error);
                                        return res.status(500).send('Hiba történt a cikk beküldése során.');
                                    }else{

                                        res.redirect('/');

                                    }
                                });
                                }

                            })


                        }
                    });
                }
            });
        }
    });



    app.post('/modify-section-user', (req, res) => {
        if (req.session.user) {
            const sectionId = req.body.sectionId;
            const conductorId = req.body.conductor;

            if (conductorId) {
                // Update the user_id (conductor) in the database
                connection.query(
                    'UPDATE section SET users_id = ? WHERE id = ?',
                    [conductorId, sectionId],
                    (error, results) => {
                        if (error) {
                            console.error('Error updating users_id:', error);
                            throw error;
                        }

                        console.log('Section conductor modified successfully');

                    }
                );
            } else {
                connection.query(
                    'UPDATE section SET users_id = NULL WHERE id = ?',
                    [sectionId],
                    (error, results) => {
                        if (error) {
                            console.error('Error updating users_id:', error);
                            throw error;
                        }

                        console.log('Section conductor modified successfully');

                    }
                );
            }

        } else {
            console.log('User not logged in. Redirecting to /');

        }
        res.redirect('/');
    });

    app.post('/modify-section-articles', (req, res) => {
        if (req.session.user) {
            const sectionId = req.body.sectionId;
            const articleId = req.body.articleAdd;
            const sectionName = req.body.sectionName;
            let actualArticleId;
            let actualUserId;
            if (articleId !== 'Error_Article') {
                connection.query('SELECT id, users_id from article WHERE title = ?', [articleId], (error, result) => {
                    if (error) {
                        console.log("error", error);
                    } else {
                        actualArticleId = result[0].id;
                        actualUserId = result[0].users_id;
                        connection.query(
                            'UPDATE article SET section_id = ? WHERE id = ?',
                            [sectionId, actualArticleId],
                            (error, results) => {
                                //console.log("aaa");
                                if (error) {
                                    console.error('Error updating section_starting_time:', error);
                                }else{
                                    connection.query('UPDATE conference SET section_name = ? WHERE article_id = ?', [sectionName, actualArticleId], (error, results) =>{
                                        if (error) {
                                            console.error('MySQL hiba: ', error);
                                        }
                                    });
                                }

                            }
                        );
                    }
                });
            }
        } else {
            console.log('User not logged in. Redirecting to /');

        }
        res.redirect('/');
    });


    app.post('/modify-section-date', (req, res) => {
        if (req.session.user) {
            const sectionId = req.body.sectionId;
            const rawDateTime = req.body.startDateTime;

            if (rawDateTime) {
                connection.query(
                    'UPDATE section SET section_starting_time = ? WHERE id = ?',
                    [rawDateTime, sectionId],
                    (error, results) => {
                        if (error) {
                            console.error('Error updating section_starting_time:', error);
                            throw error;
                        }

                        console.log('Section date modified successfully');

                    }
                );
            } else {

                connection.query(
                    'UPDATE section SET section_starting_time = NULL WHERE id = ?',
                    [sectionId],
                    (error, results) => {
                        if (error) {
                            console.error('Error updating section_starting_time:', error);
                            throw error;
                        }
                        console.log('Section date modified successfully');
                    }
                );
            }

        } else {
            console.log('User not logged in. Redirecting to /');

        }
        res.redirect('/');
    });

    app.post('/modify-section-delete-section', (req, res) => {
        if (req.session.user) {
            const sectionId = req.body.sectionDelete;
            console.log(sectionId);
            if (sectionId !== "Error_Section") {

                connection.query('SELECT title FROM article WHERE section_id = ?', [sectionId], (error, results) => {
                    if (error) {
                        console.error('MySQL hiba: ', error);
                    }
                    if (results.length > 0) {
                        console.log("Nem törölhető");
                    } else if (results.length == 0) {
                        console.log("Törölhető");

                        connection.query('DELETE FROM section WHERE id   = ?', [sectionId], (error, results) => {
                            if (error) {
                                console.error('MySQL hiba: ', error);
                            }
                        })
                    }

                });
            }

            res.redirect('/');

        }
    });

    app.post('/modify-section-delete-articles', (req, res) => {
        if (req.session.user) {
            //const sectionId = req.body.sectionId;
            const articleId = req.body.articleDelete;
            console.log(articleId);
            if (articleId !== "Error_Article") {

                connection.query(
                    'DELETE FROM article WHERE title = ?',
                    [articleId],
                    (error, results) => {
                        if (error) {
                            console.error('MySQL hiba: ', error);
                            return res.status(500).send('Error updating article section.');
                        }

                        console.log('Article removed from section successfully');

                    }
                );
            }

            res.redirect('/');

        }
    });

    app.post('/modify-section-remove-articles', (req, res) => {
        if (req.session.user) {
            const articleId = req.body.articleDetach;
            if (articleId !== "Error_Article") {

                connection.query(
                    'UPDATE article SET section_id = NULL WHERE title = ?',
                    [articleId],
                    (error, results) => {
                        if (error) {
                            console.error('MySQL hiba: ', error);
                            return res.status(500).send('Error updating article section.');
                        }

                        console.log('Article removed from section successfully');

                    }
                );
            }

            res.redirect('/');

        }
    });


    app.post('/modify-conference-date', (req, res) => {
        if (req.session.user) {
            const articleTitle = req.body.articleTitle;
            const articleDate = req.body.startDateTime;

            console.log("a cím: "+ articleTitle);

            if (articleDate) {

                connection.query('SELECT id FROM article WHERE title = ?', [articleTitle], (error, results) => {
                    if (error) {
                        console.error('MySQL hiba: ', error);
                        //return res.status(500).send('Error updating article section.');
                        //res.redirect('/');
                    } else {
                        if (results && results.length > 0) {
                            articleId = results[0].id;
                            console.log("az id: " +articleId);
                            connection.query('UPDATE conference SET conference_starting_time = ? WHERE article_id = ?', [articleDate, articleId], (error, results) => {
                                if (error) {
                                    console.error('MySQL hiba: ', error);
                                    //return res.status(500).send('Error updating article section.');
                                }
                            });
                        } else {
                            console.error('Article not found.');
                            //return res.status(404).send('Article not found.');
                        }
                    }
                });


            }else{
                connection.query('SELECT id FROM article WHERE title = ?', [articleTitle], (error, results) => {
                    if (error) {
                        console.error('MySQL hiba: ', error);
                        //return res.status(500).send('Error updating article section.');
                        //res.redirect('/');
                    }else{
                        if (results && results.length > 0){
                            articleId = results[0].id;
                            console.log("az id: " +articleId);
                            connection.query('UPDATE conference SET conference_starting_time = ? WHERE article_id = ?', [articleDate, articleId], (error, results) => {
                                if (error) {
                                    console.error('MySQL hiba: ', error);
                                    //return res.status(500).send('Error updating article section.');
                                }else{
                                    connection.query('UPDATE conference SET conference_starting_time = NULL WHERE article_id = ?', [articleId], (error, results) =>{
                                            if (error) {
                                                console.error('MySQL hiba: ', error);
                                                return res.status(500).send('Error updating article section.');
                                            }
                                        }
                                    );
                                }
                            });
                        }
                    }


                })

            }

            res.redirect('/');

        }
    });

    app.post('/modify-conference-length', (req, res) => {
        if (req.session.user) {
            const articleTitle = req.body.articleTitle;
            const articleLength = req.body.articleLength;


            if (articleLength !== 'noTime') {

                connection.query('SELECT id FROM article WHERE title = ?', [articleTitle], (error, results)=>{
                    if (error) {
                        console.error('MySQL hiba: ', error);
                    }else{
                        const articleId = results[0].id;
                        connection.query('UPDATE conference SET length = ? WHERE article_id = ?', [parseInt(articleLength), articleId], (error, results) =>{
                            if (error) {
                                console.error('MySQL hiba: ', error);

                            }
                        });
                    }
                })

            }else{
                connection.query('UPDATE conference SET length = NULL WHERE article_id = ?', [articleId], (error, results) =>{
                        if (error) {
                            console.error('MySQL hiba: ', error);

                        }
                    }
                );
            }

            res.redirect('/');

        }
    });

    const PORT = 3000;
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}`);
    });


    app.post('/submit-section', (req, res) => {
        if (!req.session.user) {
            return res.status(401).send('Nem vagy bejelentkezve.');
        }

        const userId = req.session.user.id;
        const title = req.body.sectiontitle;
        //console.log(userId);

        connection.query('SELECT id FROM section WHERE section_name = ?', [title], function (error, results) {
            if (error) {
                console.error('MySQL hiba: ', error);
                return res.status(500).send('Hiba történt a cikk beküldése során.');
            } else if (results.length > 0) {
                res.send('Registration failed. Section name is already taken.');
            } else {
                connection.query('INSERT INTO section (id, section_name) VALUES (NULL, ?)', [title], (error, results) => {
                    if (error) {
                        console.error('MySQL hiba: ', error);
                        return res.status(500).send('Hiba történt a cikk beküldése során.');
                    }
                    res.redirect('/main');
                });
            }
        });
    });

    var registered = false;
    var fromLogoutButton;


    app.get('/', (req, res, next) => {
        fromLogoutButton = req.query.fromLogoutButton === 'true';
        console.log(fromLogoutButton);

        if (req.session.user) {
            const userId = req.session.user.id;

            connection.query('SELECT * FROM article', (error, allArticles)=>{
                if (error) {
                    console.error('MySQL hiba: ', error);
                    res.status(500).send('Hiba történt lekérdezés közben.');
                }else{
                    connection.query('SELECT * FROM article WHERE users_id = ?', [userId], (error, userArticles) => {
                        if (error) {
                            console.error('MySQL hiba: ', error);
                            res.status(500).send('Hiba történt lekérdezés közben.');
                        } else {
                            connection.query('SELECT * FROM section ORDER BY section_starting_time DESC', (error, sections) => {
                                if (error) {
                                    console.error('MySQL hiba: ', error);
                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                } else {
                                    connection.query('SELECT * FROM article JOIN section ON article.section_id = section.id', (error, articles) => {
                                        if (error) {
                                            console.error('MySQL hiba: ', error);
                                            res.status(500).send('Hiba történt lekérdezés közben.');
                                        } else {
                                            connection.query('SELECT * FROM users', (error, users) => {
                                                if (error) {
                                                    console.log('MySQL hiba: ', error);
                                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                                } else {


                                                    connection.query('SELECT * FROM article WHERE section_id IS NULL', (error, nosectionarticles) => {
                                                        if (error) {
                                                            console.error('MySQL hiba: ', error);
                                                            res.status(500).send('Hiba történt lekérdezés közben.');
                                                        } else {


                                                            connection.query('SELECT * FROM article WHERE section_id IS NULL AND users_id = ?', [userId], (error, notCategorizedUserArticles) =>{
                                                                if (error) {
                                                                    console.error('MySQL hiba: ', error);
                                                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                                                }else{
                                                                    connection.query('SELECT * FROM conference', (error, conference)=>{
                                                                        if (error) {
                                                                            console.error('MySQL hiba: ', error);
                                                                            res.status(500).send('Hiba történt lekérdezés közben.');
                                                                        }else{


                                                                            connection.query('SELECT * FROM article', (error, articlesForLength) =>{
                                                                                if (error) {
                                                                                    console.error('MySQL hiba: ', error);
                                                                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                                                                }else{
                                                                                    console.log("END---");
                                                                                    res.render('main', {
                                                                                        sections: sections,
                                                                                        articles: articles,
                                                                                        users: users,
                                                                                        nosectionarticles: nosectionarticles,
                                                                                        userArticles: userArticles,
                                                                                        fromLogoutButton: fromLogoutButton,
                                                                                        allArticles: allArticles,
                                                                                        notCategorizedUserArticles: notCategorizedUserArticles,
                                                                                        conference: conference,
                                                                                        articlesForLength: articlesForLength
                                                                                    });
                                                                                }
                                                                                })

                                                                        }
                                                                    })

                                                                }
                                                            })
                                                            //console.log(userArticles);

                                                        }

                                                    });
                                                }
                                            });

                                        }
                                    });
                                }
                            });
                        }
                    });
                }
            })
        } else {
            connection.query('SELECT * FROM section ORDER BY section_starting_time DESC', (error, sections) => {
                if (error) {
                    console.error('MySQL hiba: ', error);
                    res.status(500).send('Hiba történt lekérdezés közben.');
                } else {
                    connection.query('SELECT * FROM article JOIN section ON article.section_id = section.id GROUP BY article.title ORDER BY article.title ASC', (error, articles) => {
                        if (error) {
                            console.error('MySQL hiba: ', error);
                            res.status(500).send('Hiba történt lekérdezés közben.');
                        } else {
                            connection.query('SELECT * FROM users', (error, users) => {
                                if (error) {
                                    console.log('MySQL hiba: ', error);
                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                } else {
                                    connection.query('SELECT * FROM article WHERE section_id IS NULL', (error, nosectionarticles) => {
                                        if (error) {
                                            console.error('MySQL hiba: ', error);
                                            res.status(500).send('Hiba történt lekérdezés közben.');
                                        } else {

                                            connection.query('SELECT * FROM conference', (error, conference)=>{
                                                if (error) {
                                                    console.error('MySQL hiba: ', error);
                                                    res.status(500).send('Hiba történt lekérdezés közben.');
                                                }else{

                                                    connection.query('SELECT * FROM article', (error, articlesForLength)=>{
                                                        if (error) {
                                                            console.error('MySQL hiba: ', error);
                                                            res.status(500).send('Hiba történt lekérdezés közben.');
                                                        }else{
                                                            console.log("END---")
                                                            res.render('main', {
                                                                sections: sections,
                                                                articles: articles,
                                                                users: users,
                                                                nosectionarticles: nosectionarticles,
                                                                fromLogoutButton: fromLogoutButton,
                                                                conference: conference,
                                                                articlesForLength: articlesForLength
                                                            });
                                                        }
                                                    })


                                                }
                                            })

                                        }

                                    });
                                }
                            });

                        }
                    });
                }
            });
        }
    });
}