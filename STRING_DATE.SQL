# MY SQL / STRING, DATE

# 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 
# 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.

# WHERE 컬럼명 IN('값', '값2') : 값인 행을 추출
# WHERE 컬럼명 NOT IN('값') 도 사용 가능 : 값을 포함하지 않은 행을 추출

SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ("Lucy", "Ella", "Pickle", "Rogan", "Sabrina", "Mitty")
ORDER BY ANIMAL_ID

# 보호소에 돌아가신 할머니가 기르던 개를 찾는 사람이 찾아왔습니다. 
# 이 사람이 말하길 할머니가 기르던 개는 이름에 'el'이 들어간다고 합니다. 
# 동물 보호소에 들어온 동물 이름 중, 이름에 EL이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요.
# 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.

# WHERE 컬럼명 LIKE "%$$%" $$를 포함하는 행 추출, "%$$ " 일경우 마지막이 $$, "$$%"일 경우 시작이 $$

SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE NAME LIKE "%EL%" AND ANIMAL_TYPE = "DOG" 
ORDER BY NAME

# 보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 
# 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 
# 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 
# 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.

# CASE WHEN '조건' THEN '반환값' ELSE '반환값' END

SELECT ANIMAL_ID, NAME,
    CASE 
        WHEN SEX_UPON_INTAKE LIKE "%NEUTERED%" OR SEX_UPON_INTAKE LIKE "%SPAYED%"
        THEN "O"
        ELSE "X"
    END AS "중성화" -- AS () 는 컬럼명 바꾸기
FROM ANIMAL_INS

# 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.

SELECT INS.ANIMAL_ID, INS.NAME -- 아이디와 이름 출력
FROM ANIMAL_INS INS, ANIMAL_OUTS OUTS -- 두개의 TABLE 사용
WHERE INS.ANIMAL_ID = OUTS.ANIMAL_ID -- 조건, 입양간 동물
ORDER BY OUTS.DATETIME - INS.DATETIME DESC -- 보호소에 있었던 날짜
LIMIT 2 -- 두마리 출력

# ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 
# 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 아이디 순으로 조회해야 합니다.

# DATE_FORMAT(DATETIME, 형식), 
# 형식은 %Y (4자리 연도), %y (2자리 연도), %M (영어-월), %m (월), %D (일-th), %d (일), 
# %H (24시간), %h (12시간), %i, %s 등

SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, "%Y-%m-%d") AS 날짜
FROM ANIMAL_INS
ORDER BY ANIMAL_ID
