-- PARTIE 1
-- 1. Afficher nom complet de l'étudiant et l'intitulé de sa formation
SELECT first_name, last_name, course_name FROM student
JOIN course ON student.course_id = course.course_id;

-- 2. Lister les etudiants inscrits en Data Analyst
SELECT * FROM student
JOIN course ON student.course_id = course.course_id
WHERE course_name = "Data Analyst";

-- 3. Lister les exams avec prenom, nom de l'etudiant, nom du cours, la note et la date
SELECT first_name, last_name, course_name, score, exam_date FROM exam
JOIN course ON exam.course_id = course.course_id
JOIN student ON exam.student_id = student.student_id;

-- PARTIE 2
-- 4. Afficher tous les etudiants avec leur formation, y compris ceux sans formation
SELECT first_name, last_name, course_name FROM student
LEFT JOIN course ON student.course_id = course.course_id;

-- 5. Afficher les étudiants sans formation ( NULL )
SELECT first_name, last_name, course_name FROM student
LEFT JOIN course ON student.course_id = course.course_id
WHERE course_name IS NULL;

-- 6. Afficher tous les etudiants avec leur examens, meme s'ils n'en ont pas passé
SELECT * FROM student
LEFT JOIN exam ON exam.student_id = student.student_id;

-- PARTIE 3
-- 7. Afficher toutes les formations meme si aucun etudiant n'est inscrit
SELECT * FROM course;

-- 8. Afficher les examens associés à un cours, y compris les cours sans examen
SELECT * FROM exam
RIGHT JOIN course on exam.course_id = course.course_id;

-- PARTIE 4
-- 9. Lister toutes les combinaisons etudiant-formation meme sans correspondance
SELECT * FROM student
LEFT JOIN course ON student.course_id = course.course_id
UNION 
SELECT * FROM student
RIGHT JOIN course ON student.course_id = course.course_id;

-- 10. Lister tous les examens et etudiants meme si l'un des deux est manquant
SELECT * FROM student
LEFT JOIN exam ON student.student_id = exam.student_id
UNION
SELECT * FROM student
RIGHT JOIN exam ON student.student_id = exam.student_id;

-- PARTIE 5
-- 11. Trouver les paires d'etudiant nes la meme annee
SELECT * FROM student A, student B
WHERE A.birth_year = B.birth_year AND A.student_id != B.student_id;

-- 12. Associer chaque etudiant a ceux qui sont plus ages qu'eux
SELECT * FROM student A, student B
WHERE A.birth_year < B.birth_year;

-- PARTIE 6
-- 13. Generer les combinaison possibles entre etudiant et type d'examen
SELECT * FROM student
CROSS JOIN (SELECT exam_type FROM exam GROUP BY exam_type) AS types;

-- 14. Compter le nombre de lignes du cross join précedant
SELECT COUNT(*) FROM student
CROSS JOIN (SELECT exam_type FROM exam GROUP BY exam_type) AS types;

-- PARTIE 7
-- 15. Afficher la moyenne des notes par etudiant
SELECT first_name, last_name, TRUNCATE(AVG(score), 2) AS moyenne FROM exam
JOIN student ON exam.student_id = student.student_id
GROUP BY student.student_id;

-- 16. Afficher la note maximale obtenue par cours
SELECT course_name, MAX(score) FROM course
JOIN exam ON exam.course_id = course.course_id
GROUP BY course_name;

-- 17. Lister les etudiants ayant obtenu une note superieure à 15 à au moins un examen
SELECT DISTINCT first_name, last_name FROM student
JOIN exam ON exam.student_id = student.student_id
WHERE exam.score > 10; -- No duplicates with 15
