--
-- PostgreSQL database dump
--

\restrict NdGQ2VK2fMG2THGtN1dHEBdkWIXXH15urGwWlnmNpbz3abdwxkONY4aSXsWJBPe

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: SessionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SessionStatus" AS ENUM (
    'PLANNED',
    'CANCELED',
    'DONE'
);


ALTER TYPE public."SessionStatus" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Absence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Absence" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    "studentId" text NOT NULL,
    reason text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Absence" OWNER TO postgres;

--
-- Name: Class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Class" (
    id text NOT NULL,
    "teacherId" text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Class" OWNER TO postgres;

--
-- Name: ClassSession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClassSession" (
    id text NOT NULL,
    date timestamp(3) without time zone NOT NULL,
    status public."SessionStatus" DEFAULT 'PLANNED'::public."SessionStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "classTermId" text NOT NULL
);


ALTER TABLE public."ClassSession" OWNER TO postgres;

--
-- Name: ClassTerm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClassTerm" (
    id text NOT NULL,
    "classId" text NOT NULL,
    "semesterId" text NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    weekdays integer[],
    "perSessionFee" numeric(10,2) NOT NULL,
    currency text DEFAULT 'CNY'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ClassTerm" OWNER TO postgres;

--
-- Name: Enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Enrollment" (
    id text NOT NULL,
    "studentId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "classTermId" text NOT NULL
);


ALTER TABLE public."Enrollment" OWNER TO postgres;

--
-- Name: Semester; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Semester" (
    id text NOT NULL,
    "teacherId" text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Semester" OWNER TO postgres;

--
-- Name: Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Student" (
    id text NOT NULL,
    name text NOT NULL,
    phone text,
    note text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "classId" text NOT NULL
);


ALTER TABLE public."Student" OWNER TO postgres;

--
-- Name: Teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Teacher" (
    id text NOT NULL,
    email text NOT NULL,
    name text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "passwordHash" text NOT NULL
);


ALTER TABLE public."Teacher" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Data for Name: Absence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Absence" (id, "sessionId", "studentId", reason, "createdAt") FROM stdin;
cmf745r0y0001nm0kjdjzu6g6	cmf6dhir60009nmzcf8nsedb5	cmf6pcv890000nmw8c3anrz1f	\N	2025-09-05 17:33:15.15
cmf745u240005nm0kb0bu6net	cmf6dhir60009nmzcf8nsedb5	cmf6pcv890002nmw86w5vhhwy	\N	2025-09-05 17:33:19.084
cmf745uqr0007nm0k6q1f0fkz	cmf6dhir60009nmzcf8nsedb5	cmf71byid0006nmw8hnx1k838	\N	2025-09-05 17:33:19.971
cmf749dcq0009nm0k8b291y27	cmf6dhir60009nmzcf8nsedb5	cmf6pcv890001nmw84t19zpen	\N	2025-09-05 17:36:04.059
cmf74nn8d001hnm0k1k074sci	cmf6dhir6000dnmzcalq9v4sz	cmf74bbsd000dnm0krmbd3nwt	\N	2025-09-05 17:47:10.045
cmf74npk5001jnm0kiqt9zsgm	cmf6dhir6000dnmzcalq9v4sz	cmf74bbsd000fnm0kl85i0s0q	\N	2025-09-05 17:47:13.061
cmf74nvkh001lnm0kt7k45mmz	cmf6dhir6000dnmzcalq9v4sz	cmf74bbsd000gnm0kclu068cy	\N	2025-09-05 17:47:20.849
cmf74w74v001nnm0k1u5wsm67	cmf6dhir6000dnmzcalq9v4sz	cmf74bbsd000bnm0kzt9umixe	\N	2025-09-05 17:53:49.087
cmf7lvwpz002inma4h2ccntwk	cmf7lv4id001gnma4eokpme2x	cmf7lrsm3000gnma49fzlf6f7	\N	2025-09-06 01:49:29.064
cmf7lvwtp002knma4618pn23t	cmf7lv4id001gnma4eokpme2x	cmf7lrsm30008nma4u20zai29	\N	2025-09-06 01:49:29.198
cmf7ly64x002qnma49hvl8pwb	cmf7lv4id001gnma4eokpme2x	cmf7lrsm3000dnma4o6p5b46p	\N	2025-09-06 01:51:14.577
cmf7lycvh002snma4mqw78rcr	cmf7lv4id001gnma4eokpme2x	cmf7lrsm3000inma48ckaufrp	\N	2025-09-06 01:51:23.309
cmf7lzqb0002unma44b1h48z0	cmf7lv4id001gnma4eokpme2x	cmf7lrsm3000knma4lw3wigjn	\N	2025-09-06 01:52:27.372
cmf7tl79n004knmm8g5pq65r1	cmf7tkmss002vnmm8aigrxtdx	cmf7thxz7000inmm8efws40ho	\N	2025-09-06 05:25:06.443
cmf7tl7cd004onmm8w2sgs597	cmf7tkmss002vnmm8aigrxtdx	cmf7thxz7000anmm8sxaoa0ii	\N	2025-09-06 05:25:06.541
cmf7tl8xk004qnmm8a8bkbiu0	cmf7tkmss002vnmm8aigrxtdx	cmf7thxz7000fnmm8cmy9sjly	\N	2025-09-06 05:25:08.601
cmf7tldx0004snmm8xfydjwmh	cmf7tkmss002vnmm8aigrxtdx	cmf7thxz8000lnmm8t36asp2k	\N	2025-09-06 05:25:15.061
cmf7tljov004unmm8oqoau3qc	cmf7tkmss002vnmm8aigrxtdx	cmf7thxz8000nnmm8rwjg2ekg	\N	2025-09-06 05:25:22.543
cmf7touk2005onmm8fx54l2bc	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog000wnmm8wrcvp1wb	\N	2025-09-06 05:27:56.594
cmf7tow04005qnmm8eftr5qts	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog000ynmm8uypypmzl	\N	2025-09-06 05:27:58.468
cmf7tphso005snmm8jg19mama	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog0018nmm8h6f0wqef	\N	2025-09-06 05:28:26.713
cmf7tpzhh005unmm8oyc1276b	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog001fnmm8pojptluw	\N	2025-09-06 05:28:49.638
cmf7tq70s005wnmm8gs1mn8yl	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog001inmm8kfk6g419	\N	2025-09-06 05:28:59.404
cmf7tqaj4005ynmm8y503w6cl	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog001lnmm8w9kij5j5	\N	2025-09-06 05:29:03.952
cmf7tqp4d0060nmm84nnkokof	cmf7tkljt001tnmm8heh8hrv5	cmf7tinog001hnmm8dvnnkvwk	\N	2025-09-06 05:29:22.861
cmf7y2w2b008gnmm816qwfoed	cmf7xxfnm006snmm8cek0c6nj	cmf7xwgol0069nmm89vwrvfyg	\N	2025-09-06 07:30:50.195
cmf7y2xxu008inmm88qf9ajur	cmf7xxfnm006snmm8cek0c6nj	cmf7xwgol0066nmm8bw92foli	\N	2025-09-06 07:30:52.627
cmf7y3102008knmm8p2zb0mtl	cmf7xxfnm006snmm8cek0c6nj	cmf7xwgol006inmm8nmlcleyh	\N	2025-09-06 07:30:56.594
cmf7y3o8k008mnmm8csgvya7r	cmf7xxfnm006snmm8cek0c6nj	cmf7xwgol006knmm8hrmcsmz1	\N	2025-09-06 07:31:26.709
cmf7y3vjr008onmm8fngcnb1v	cmf7xxfnm006snmm8cek0c6nj	cmf7xwgol006gnmm8ba6x7b5k	\N	2025-09-06 07:31:36.184
cmf82ll8000amnmm89i9rmtq3	cmf82jtb1008unmm8dpd38ag9	cmf82kzu300a0nmm86d2zw0y8	\N	2025-09-06 09:37:21.073
cmf82lnhs00aonmm8cwgbud4v	cmf82jtb1008unmm8dpd38ag9	cmf82kzu300a4nmm85ut1408p	\N	2025-09-06 09:37:24.016
cmf82lp4k00aqnmm823vrlrq2	cmf82jtb1008unmm8dpd38ag9	cmf82kzu3009vnmm8knsfnw8f	\N	2025-09-06 09:37:26.133
cmf97ksqa001rnmk85awrir8c	cmf97j3om0005nmk8wu6hminw	cmf97jsjd001enmk8wbh4rr7w	\N	2025-09-07 04:44:28.403
cmf9f1e4j004hnmk86faky95f	cmf9f0iiq002snmk8uwo9blzg	cmf9ezsb3002onmk8a1vllvbf	\N	2025-09-07 08:13:19.939
cmf9l3grw008znmk81sy74xba	cmf9l2rkc007cnmk8wrcagivb	cmf9l1x8s006tnmk8cxv4gir3	\N	2025-09-07 11:02:54.381
cmf9l3ide0091nmk8buxb8ds3	cmf9l2rkc007cnmk8wrcagivb	cmf9l1x8s006unmk8dwnnll68	\N	2025-09-07 11:02:56.451
cmf9l3jw90093nmk88a8nxz6u	cmf9l2rkc007cnmk8wrcagivb	cmf9l1x8s006vnmk8lpi75za1	\N	2025-09-07 11:02:58.425
\.


--
-- Data for Name: Class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Class" (id, "teacherId", name, "createdAt", "updatedAt") FROM stdin;
cmf6d8vod0001nmzcsrz1nrpn	cmf5kt0v30000nmjwygw2gw2z	周六早八	2025-09-05 04:59:51.513	2025-09-05 04:59:51.513
cmf7lmw5m0004nma4r49aqtkd	cmf7llf0t0000nma4r3ymsb1x	新班5（周六早八）	2025-09-06 01:42:28.427	2025-09-06 03:23:32.84
cmf7pazt4002wnma4yfh6bysi	cmf7llf0t0000nma4r3ymsb1x	周六早十	2025-09-06 03:25:11.752	2025-09-06 03:25:11.752
cmf7qo3as0001nm28okecxr6p	cmf5kt0v30000nmjwygw2gw2z	周六早十	2025-09-06 04:03:22.417	2025-09-06 04:03:22.417
cmf7th28w0006nmm80tv70z6b	cmf7tg2wg0002nmm8za4p7xuq	新班5（周六早八）	2025-09-06 05:21:53.312	2025-09-06 05:21:53.312
cmf7tie4k000vnmm81jb31fpz	cmf7tg2wg0002nmm8za4p7xuq	周六早十	2025-09-06 05:22:55.364	2025-09-06 05:22:55.364
cmf7xw3o20062nmm8d35vvkob	cmf7tg2wg0002nmm8za4p7xuq	新班6（周六下二）	2025-09-06 07:25:33.458	2025-09-06 07:25:43.31
cmf82ixo4008qnmm8d7wud1sd	cmf7tg2wg0002nmm8za4p7xuq	新班2（周六下三）	2025-09-06 09:35:17.236	2025-09-06 09:35:17.236
cmf9722ms0001nmk8m0nhor05	cmf7tg2wg0002nmm8za4p7xuq	新班1（周天早十）	2025-09-07 04:29:54.766	2025-09-07 04:29:54.766
cmf9exch6001tnmk8iz4ozfxy	cmf7tg2wg0002nmm8za4p7xuq	新班10（周天下二）	2025-09-07 08:10:11.178	2025-09-07 08:10:11.178
cmf9hoj6e004jnmk8dt3nd4xg	cmf7tg2wg0002nmm8za4p7xuq	新班9（周天下四）	2025-09-07 09:27:18.807	2025-09-07 09:27:18.807
cmf9l0u2q006nnmk81pjfrj4m	cmf7tg2wg0002nmm8za4p7xuq	周天晚	2025-09-07 11:00:51.65	2025-09-07 11:00:51.65
\.


--
-- Data for Name: ClassSession; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ClassSession" (id, date, status, "createdAt", "updatedAt", "classTermId") FROM stdin;
cmf6dhir40007nmzcynf6qjes	2025-09-06 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir60009nmzcf8nsedb5	2025-09-13 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir6000bnmzc3evkfc6g	2025-09-20 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir6000dnmzcalq9v4sz	2025-09-27 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir6000fnmzcbwqwdqu9	2025-10-04 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000hnmzcrjg1wu8w	2025-10-11 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000jnmzcl92bku2b	2025-10-18 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000lnmzcctwe1ond	2025-10-25 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000nnmzc0quvu9tv	2025-11-01 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000pnmzctgvv1rfo	2025-11-08 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000rnmzch5q1xm2l	2025-11-15 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000tnmzc6hdq7i4m	2025-11-22 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir7000vnmzcrnirr5wp	2025-11-29 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir8000xnmzcku8j3htf	2025-12-06 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir8000znmzc5cs0ynqy	2025-12-13 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir80011nmzckzaax8yx	2025-12-20 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir80013nmzczvlwsb4y	2025-12-27 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir80015nmzc0mjv4kpd	2026-01-03 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf6dhir80017nmzclyld9u60	2026-01-10 00:00:00	PLANNED	2025-09-05 05:06:34.668	2025-09-05 05:06:34.668	cmf6dawyo0005nmzcmkpzr9d6
cmf76c6fk000pnmdwybpwmogl	2026-01-10 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm000rnmdwdvmnaxxm	2026-01-13 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm000tnmdwrco9vsk8	2026-01-15 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm000vnmdw1en4rzc6	2026-01-17 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm000xnmdwe7s7rh2f	2026-01-20 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm000znmdwjyujis7i	2026-01-22 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fm0011nmdwwn81667e	2026-01-24 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn0013nmdwjxgkdosq	2026-01-27 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn0015nmdwgio4k23l	2026-01-29 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn0017nmdwi3o07j9f	2026-01-31 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn0019nmdww0izr25n	2026-02-03 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn001bnmdweiyhwdrv	2026-02-05 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf76c6fn001dnmdw2g7khd4t	2026-02-07 00:00:00	PLANNED	2025-09-05 18:34:14.285	2025-09-05 18:34:14.285	cmf726ave000bnmw8e7x0pi30
cmf7lv4id001gnma4eokpme2x	2025-09-06 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ie001inma4bksmgun0	2025-09-13 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001knma4gazwgkfw	2025-09-20 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001mnma4gjg9h9j7	2025-09-27 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001onma4q33b29co	2025-10-04 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001qnma4jmr2723x	2025-10-11 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001snma450p3v0py	2025-10-18 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001unma4s99z03k5	2025-10-25 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001wnma46mzigj7l	2025-11-01 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if001ynma4829nyrte	2025-11-08 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4if0020nma4un251exk	2025-11-15 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig0022nma4tfp95yj1	2025-11-22 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig0024nma47ck4mtz0	2025-11-29 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig0026nma4b4f18p5v	2025-12-06 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig0028nma4xvgulx2y	2025-12-13 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig002anma4nxf7fgg4	2025-12-20 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig002cnma4y3rvaa3o	2025-12-27 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig002enma47b449r7o	2026-01-03 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7lv4ig002gnma4w76gouhv	2026-01-10 00:00:00	PLANNED	2025-09-06 01:48:52.5	2025-09-06 01:48:52.5	cmf7lugii000snma48bkhqpw1
cmf7pbvfi0030nma4hj85l4w6	2025-09-06 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj0032nma4jrjb8o7c	2025-09-13 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj0034nma4jbrji3wj	2025-09-20 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj0036nma4xgqd0t05	2025-09-27 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj0038nma4rhjc89l3	2025-10-04 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj003anma43pu2a5nv	2025-10-11 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj003cnma44l45kp4x	2025-10-18 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfj003enma4o7qu4bzg	2025-10-25 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003gnma410bpxbvc	2025-11-01 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003inma4976g13cl	2025-11-08 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003knma4xa2rqz5f	2025-11-15 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003mnma4j9ulw8v6	2025-11-22 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003onma4ov32v3o8	2025-11-29 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003qnma4jskhicz2	2025-12-06 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003snma43htonnn7	2025-12-13 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfk003unma4wtqz56bo	2025-12-20 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfl003wnma491l7kkl7	2025-12-27 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7pbvfl003ynma4yjv7thvl	2026-01-03 00:00:00	PLANNED	2025-09-06 03:25:52.734	2025-09-06 03:25:52.734	cmf7pbt3l002ynma4msfw51fu
cmf7tkljt001tnmm8heh8hrv5	2025-09-06 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tklju001vnmm8gilqwkwh	2025-09-13 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljv001xnmm85lc2hihm	2025-09-20 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljv001znmm8lvf1p8v6	2025-09-27 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljv0021nmm87zgww57i	2025-10-04 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljv0023nmm87u49smjv	2025-10-11 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljw0025nmm8xfmvayvp	2025-10-18 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljw0027nmm8p273q3z3	2025-10-25 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljw0029nmm8l7dxhek6	2025-11-01 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljx002bnmm898f6thcq	2025-11-08 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljx002dnmm84k7risr7	2025-11-15 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljx002fnmm8k6u0gu1n	2025-11-22 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljx002hnmm8plrwaomr	2025-11-29 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljy002jnmm8qx52t5h5	2025-12-06 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljy002lnmm8sff8rwo1	2025-12-13 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljy002nnmm8qxmn74if	2025-12-20 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljy002pnmm8ytaron7w	2025-12-27 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljy002rnmm8nhs1s2be	2026-01-03 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkljz002tnmm8qiv07uzv	2026-01-10 00:00:00	PLANNED	2025-09-06 05:24:38.295	2025-09-06 05:24:38.295	cmf7tkhwy001rnmm8x7y02m3f
cmf7tkmss002vnmm8aigrxtdx	2025-09-06 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmst002xnmm8cdwovffd	2025-09-13 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmst002znmm8mysv1urk	2025-09-20 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmst0031nmm8zyufk29g	2025-09-27 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmst0033nmm80x8olhbw	2025-10-04 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmst0035nmm8utlkx2to	2025-10-11 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu0037nmm89eidn6pv	2025-10-18 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu0039nmm8m5y5kn3v	2025-10-25 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu003bnmm876zmcdgg	2025-11-01 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu003dnmm8ojvcl164	2025-11-08 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu003fnmm8qgg2bxzy	2025-11-15 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsu003hnmm8x0bm7hxb	2025-11-22 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003jnmm8dr0x610k	2025-11-29 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003lnmm8pbab9hd0	2025-12-06 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003nnmm8fqi7sbbt	2025-12-13 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003pnmm8zmfzyvi8	2025-12-20 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003rnmm89zimz9i5	2025-12-27 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsv003tnmm8iepkoca6	2026-01-03 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkmsw003vnmm8pgn7rzq7	2026-01-10 00:00:00	PLANNED	2025-09-06 05:24:39.916	2025-09-06 05:24:39.916	cmf7tjl6l001pnmm8ffo04ev2
cmf7xxfnm006snmm8cek0c6nj	2025-09-06 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnn006unmm8gwr7h7ot	2025-09-13 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfno006wnmm83sypgcxo	2025-09-20 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfno006ynmm8k905g16y	2025-09-27 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfno0070nmm8usz7zztr	2025-10-04 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfno0072nmm8ea75vckl	2025-10-11 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfno0074nmm8fl84un1b	2025-10-18 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp0076nmm84hsjrab5	2025-10-25 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp0078nmm8ipyytyg3	2025-11-01 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007anmm8baw1lrpl	2025-11-08 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007cnmm88hgyay4y	2025-11-15 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007enmm864ns26a4	2025-11-22 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007gnmm8ve34jqwe	2025-11-29 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007inmm8bgb1g1a6	2025-12-06 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnp007knmm8wa33b9rv	2025-12-13 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnq007mnmm8ttql8sqb	2025-12-20 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnq007onmm8q1b79uu4	2025-12-27 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnq007qnmm8yf1x4495	2026-01-03 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxfnq007snmm81ot7qnzp	2026-01-10 00:00:00	PLANNED	2025-09-06 07:26:35.65	2025-09-06 07:26:35.65	cmf7xxbi5006qnmm8gy5bkbcr
cmf82jtb1008unmm8dpd38ag9	2025-09-06 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb1008wnmm8eivfp5ei	2025-09-13 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb2008ynmm8lkfrk332	2025-09-20 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb20090nmm8rnjh8r71	2025-09-27 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb20092nmm83fh1j4qk	2025-10-04 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb20094nmm8aa4sgqd1	2025-10-11 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb20096nmm8iipx64ab	2025-10-18 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb20098nmm87faptfiv	2025-10-25 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009anmm8fr9imr7l	2025-11-01 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009cnmm8oswfu1j7	2025-11-08 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009enmm8b1fhfzg8	2025-11-15 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009gnmm82t3qdrh1	2025-11-22 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009inmm8wd3gfol7	2025-11-29 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009knmm8gbt0yrit	2025-12-06 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009mnmm8xdcc76u9	2025-12-13 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb3009onmm872c1otq9	2025-12-20 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb4009qnmm8pnpzl779	2025-12-27 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb4009snmm8xx78fxa8	2026-01-03 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf82jtb5009unmm8xx5q1rfj	2026-01-10 00:00:00	PLANNED	2025-09-06 09:35:58.237	2025-09-06 09:35:58.237	cmf82jp6i008snmm81huf1qgl
cmf97j3om0005nmk8wu6hminw	2025-09-07 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3oq0007nmk8in36ljw5	2025-09-14 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3oq0009nmk89u9wlvt4	2025-09-21 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000bnmk8o4nnv4tc	2025-09-28 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000dnmk8do1fq3tq	2025-10-05 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000fnmk8u8ocf1pk	2025-10-12 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000hnmk8cdrk2sz3	2025-10-19 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000jnmk8d9goqzpy	2025-10-26 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3or000lnmk8227k1d6l	2025-11-02 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3os000nnmk89q2ailpr	2025-11-09 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3os000pnmk81ipi463n	2025-11-16 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3os000rnmk82yheseww	2025-11-23 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3os000tnmk8v17hpmef	2025-11-30 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3os000vnmk8z95n7ofi	2025-12-07 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3ot000xnmk8uazejtkk	2025-12-14 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3ot000znmk8gzlpwuje	2025-12-21 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3ot0011nmk8ob35u529	2025-12-28 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3ot0013nmk8brdvw0r7	2026-01-04 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf97j3ot0015nmk8wkgtjhbk	2026-01-11 00:00:00	PLANNED	2025-09-07 04:43:09.282	2025-09-07 04:43:09.282	cmf97ipf90003nmk88v5j9kl5
cmf9f0iiq002snmk8uwo9blzg	2025-09-07 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iiq002unmk89enz8lr5	2025-09-14 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir002wnmk80uwqpyfn	2025-09-21 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir002ynmk8n1t2skdk	2025-09-28 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir0030nmk80jgjq8wo	2025-10-05 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir0032nmk8eodnzd8p	2025-10-12 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir0034nmk8ai02isgw	2025-10-19 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir0036nmk8n9q3mms2	2025-10-26 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir0038nmk8q74djxh2	2025-11-02 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir003anmk84jqjo1oq	2025-11-09 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iir003cnmk817jzzqy9	2025-11-16 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003enmk8ii1lo68q	2025-11-23 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003gnmk8zrzqiiul	2025-11-30 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003inmk83p3x1pxs	2025-12-07 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003knmk8khc9kcn7	2025-12-14 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003mnmk8z8wsvo01	2025-12-21 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003onmk895fb2dih	2025-12-28 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003qnmk857zv17gx	2026-01-04 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f0iis003snmk84r85z45n	2026-01-11 00:00:00	PLANNED	2025-09-07 08:12:38.978	2025-09-07 08:12:38.978	cmf9f0g4s002qnmk8gbjx6pk6
cmf9hpmv80054nmk8cv716pgl	2025-09-07 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv90056nmk8tbuh6dpj	2025-09-14 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv90058nmk8mvr63ttu	2025-09-21 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005anmk80kkpkmmi	2025-09-28 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005cnmk8e51xm18r	2025-10-05 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005enmk84g2xwa3c	2025-10-12 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005gnmk8f3c38a48	2025-10-19 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005inmk8yjg6e44s	2025-10-26 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005knmk8szh09kbt	2025-11-02 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmv9005mnmk8olnxjmj4	2025-11-09 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005onmk8i2rbw4og	2025-11-16 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005qnmk8ce1y8shq	2025-11-23 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005snmk81ww695fl	2025-11-30 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005unmk8x3csaxwu	2025-12-07 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005wnmk855uywzwp	2025-12-14 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva005ynmk8owh7yfrd	2025-12-21 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmva0060nmk8gfxmz2bc	2025-12-28 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmvb0062nmk8cyepejxh	2026-01-04 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9hpmvb0064nmk8h3l2011x	2026-01-11 00:00:00	PLANNED	2025-09-07 09:28:10.244	2025-09-07 09:28:10.244	cmf9hpjss0052nmk8vxs37mw3
cmf9l2rkc007cnmk8wrcagivb	2025-09-07 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007enmk8poiprif7	2025-09-14 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007gnmk8ifu4wezc	2025-09-21 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007inmk8ddwdbbav	2025-09-28 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007knmk8z2ookuod	2025-10-05 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007mnmk8vddr9mtj	2025-10-12 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkd007onmk80jj26kuc	2025-10-19 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke007qnmk8n1a0z3a2	2025-10-26 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke007snmk81b1de5ok	2025-11-02 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke007unmk8r76kbpfu	2025-11-09 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke007wnmk86sii8ybb	2025-11-16 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke007ynmk8wok01g8s	2025-11-23 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke0080nmk8b9lpbuty	2025-11-30 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke0082nmk8vplbk8mk	2025-12-07 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke0084nmk8do4uu9i4	2025-12-14 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rke0086nmk81tvhffuq	2025-12-21 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkf0088nmk8mrimolf2	2025-12-28 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkf008anmk8v6luo0pe	2026-01-04 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
cmf9l2rkf008cnmk86w60r4m4	2026-01-11 00:00:00	PLANNED	2025-09-07 11:02:21.708	2025-09-07 11:02:21.708	cmf9l2lvq007anmk885i0xh87
\.


--
-- Data for Name: ClassTerm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ClassTerm" (id, "classId", "semesterId", "startDate", "endDate", weekdays, "perSessionFee", currency, "createdAt", "updatedAt") FROM stdin;
cmf6dawyo0005nmzcmkpzr9d6	cmf6d8vod0001nmzcsrz1nrpn	cmf6da27p0003nmzcy53ip9gw	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	200.00	CNY	2025-09-05 05:01:26.496	2025-09-05 05:01:26.496
cmf726ave000bnmw8e7x0pi30	cmf6d8vod0001nmzcsrz1nrpn	cmf71tw0p0009nmw82u3c1pgk	2026-01-09 00:00:00	2026-02-07 00:00:00	{2,4,6}	100.00	CNY	2025-09-05 16:37:41.642	2025-09-05 16:37:41.642
cmf7lugii000snma48bkhqpw1	cmf7lmw5m0004nma4r49aqtkd	cmf7lmgh70002nma45axikkuz	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	135.00	CNY	2025-09-06 01:48:21.402	2025-09-06 01:48:21.402
cmf7pbt3l002ynma4msfw51fu	cmf7pazt4002wnma4yfh6bysi	cmf7lmgh70002nma45axikkuz	2025-09-06 00:00:00	2026-01-04 00:00:00	{6}	135.00	CNY	2025-09-06 03:25:49.713	2025-09-06 03:25:49.713
cmf7tjl6l001pnmm8ffo04ev2	cmf7th28w0006nmm80tv70z6b	cmf7tgpcg0004nmm833b2a2q3	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	150.00	CNY	2025-09-06 05:23:51.165	2025-09-06 05:23:51.165
cmf7tkhwy001rnmm8x7y02m3f	cmf7tie4k000vnmm81jb31fpz	cmf7tgpcg0004nmm833b2a2q3	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	150.00	CNY	2025-09-06 05:24:33.586	2025-09-06 05:24:33.586
cmf82jp6i008snmm81huf1qgl	cmf82ixo4008qnmm8d7wud1sd	cmf7tgpcg0004nmm833b2a2q3	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	150.00	CNY	2025-09-06 09:35:52.89	2025-09-06 09:35:52.89
cmf97ipf90003nmk88v5j9kl5	cmf9722ms0001nmk8m0nhor05	cmf7tgpcg0004nmm833b2a2q3	2025-09-07 00:00:00	2026-01-11 00:00:00	{0}	150.00	CNY	2025-09-07 04:42:50.805	2025-09-07 04:42:50.805
cmf9f0g4s002qnmk8gbjx6pk6	cmf9exch6001tnmk8iz4ozfxy	cmf7tgpcg0004nmm833b2a2q3	2025-09-07 00:00:00	2026-01-11 00:00:00	{0}	150.00	CNY	2025-09-07 08:12:35.884	2025-09-07 08:12:35.884
cmf9hpjss0052nmk8vxs37mw3	cmf9hoj6e004jnmk8dt3nd4xg	cmf7tgpcg0004nmm833b2a2q3	2025-09-07 00:00:00	2026-01-11 00:00:00	{0}	150.00	CNY	2025-09-07 09:28:06.268	2025-09-07 09:28:06.268
cmf9l2lvq007anmk885i0xh87	cmf9l0u2q006nnmk81pjfrj4m	cmf7tgpcg0004nmm833b2a2q3	2025-09-07 00:00:00	2026-01-11 00:00:00	{0}	150.00	CNY	2025-09-07 11:02:14.342	2025-09-07 11:02:14.342
cmf7xxbi5006qnmm8gy5bkbcr	cmf7xw3o20062nmm8d35vvkob	cmf7tgpcg0004nmm833b2a2q3	2025-09-06 00:00:00	2026-01-10 00:00:00	{6}	100.00	CNY	2025-09-06 07:26:30.269	2025-09-11 07:53:28.473
\.


--
-- Data for Name: Enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Enrollment" (id, "studentId", "createdAt", "updatedAt", "classTermId") FROM stdin;
cmf6py1t80003nmw88iprfldo	cmf6pcv890000nmw8c3anrz1f	2025-09-05 10:55:21.261	2025-09-05 10:55:21.261	cmf6dawyo0005nmzcmkpzr9d6
cmf6py1t80004nmw8tbz5ye49	cmf6pcv890001nmw84t19zpen	2025-09-05 10:55:21.261	2025-09-05 10:55:21.261	cmf6dawyo0005nmzcmkpzr9d6
cmf6py1t80005nmw8xnyvq18l	cmf6pcv890002nmw86w5vhhwy	2025-09-05 10:55:21.261	2025-09-05 10:55:21.261	cmf6dawyo0005nmzcmkpzr9d6
cmf71cvgn0007nmw810mu3f6l	cmf71byid0006nmw8hnx1k838	2025-09-05 16:14:48.647	2025-09-05 16:14:48.647	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000unm0k6kaz3fsl	cmf74bbsd000anm0kpsy4jsxs	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000vnm0kca99b16w	cmf74bbsd000bnm0kzt9umixe	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000wnm0kbk0adw4v	cmf74bbsd000cnm0ke37hanyn	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000xnm0kxfqyzdaz	cmf74bbsd000dnm0krmbd3nwt	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000ynm0kdstys3po	cmf74bbsd000enm0k2o7jj5ee	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq000znm0k5qz1jf15	cmf74bbsd000fnm0kl85i0s0q	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0010nm0k316xbuq5	cmf74bbsd000gnm0kclu068cy	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0011nm0kmzpfe0po	cmf74bbsd000hnm0kjzib5b82	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0012nm0ku3fpe7sh	cmf74bbsd000inm0k4wm0kuff	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0013nm0kkejfwbgw	cmf74bbsd000jnm0kicz22j7g	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0014nm0khtaxzh9m	cmf74bbsd000knm0kmdm1ucwk	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0015nm0kk18jyecm	cmf74bbsd000lnm0k0ywxdk7j	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0016nm0kdpat61p7	cmf74bbsd000mnm0kr6c4uzwq	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0017nm0klgfl55n0	cmf74bbsd000nnm0kagh50sdy	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0018nm0khim8ivig	cmf74bbsd000onm0k9yca1dr0	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq0019nm0k30ggl2lo	cmf74bbsd000pnm0klybdty2b	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq001anm0k4b49rydx	cmf74bbsd000qnm0kw1hlrdsi	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq001bnm0kmkl4bp2c	cmf74bbsd000rnm0k61v68s1n	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq001cnm0k3qibod2s	cmf74bbsd000snm0kj5y0ith6	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf74cfcq001dnm0kjzcb1q6k	cmf74bbsd000tnm0knurv14at	2025-09-05 17:38:26.618	2025-09-05 17:38:26.618	cmf6dawyo0005nmzcmkpzr9d6
cmf76biip0000nmdwpua2i2tc	cmf6pcv890000nmw8c3anrz1f	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biir0001nmdww2u33neu	cmf6pcv890001nmw84t19zpen	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biir0002nmdwr0zt7fd7	cmf6pcv890002nmw86w5vhhwy	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biir0003nmdwzz3xa3fy	cmf71byid0006nmw8hnx1k838	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biir0005nmdw8119ddi8	cmf74bbsd000bnm0kzt9umixe	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biir0006nmdwdjpoy7rx	cmf74bbsd000cnm0ke37hanyn	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis0007nmdwiurqdbfv	cmf74bbsd000dnm0krmbd3nwt	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis0008nmdwoxn83w16	cmf74bbsd000enm0k2o7jj5ee	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis0009nmdw97zarujm	cmf74bbsd000fnm0kl85i0s0q	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000anmdwa2pd24oa	cmf74bbsd000gnm0kclu068cy	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000bnmdw681d55xd	cmf74bbsd000hnm0kjzib5b82	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000cnmdw56vfhars	cmf74bbsd000inm0k4wm0kuff	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000dnmdwe5fbxqea	cmf74bbsd000jnm0kicz22j7g	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000enmdwemh8e4f9	cmf74bbsd000knm0kmdm1ucwk	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000fnmdwsirf9nhj	cmf74bbsd000lnm0k0ywxdk7j	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000gnmdwevza0cjm	cmf74bbsd000mnm0kr6c4uzwq	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000hnmdw5ndgc67f	cmf74bbsd000nnm0kagh50sdy	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000inmdwf1jy17e8	cmf74bbsd000onm0k9yca1dr0	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000jnmdwnf454a13	cmf74bbsd000pnm0klybdty2b	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000knmdwawphssmx	cmf74bbsd000qnm0kw1hlrdsi	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000lnmdwnj2jvkzt	cmf74bbsd000rnm0k61v68s1n	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000mnmdwp61fi1z1	cmf74bbsd000snm0kj5y0ith6	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf76biis000nnmdwhlb5ecsc	cmf74bbsd000tnm0knurv14at	2025-09-05 18:33:43.295	2025-09-05 18:33:43.295	cmf726ave000bnmw8e7x0pi30
cmf7luslh000tnma4g0k29jf4	cmf7lrsm30005nma4uc15qu7q	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000unma48fjo8dwm	cmf7lrsm30006nma4v909bnp2	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000vnma4qydktwy0	cmf7lrsm30007nma4zfmeyhfe	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000wnma4roxe09m6	cmf7lrsm30008nma4u20zai29	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000xnma4qx6tubl4	cmf7lrsm30009nma4qyyxmcc9	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000ynma48iuna7fu	cmf7lrsm3000anma42sx7mv5v	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh000znma4l6ts4y6t	cmf7lrsm3000bnma4obewzbx0	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7luslh0010nma48z64cy0m	cmf7lrsm3000cnma400uoyo57	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0011nma4neh72hnm	cmf7lrsm3000dnma4o6p5b46p	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0012nma40734t9rd	cmf7lrsm3000enma42uvea5ju	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0013nma453mw4s9z	cmf7lrsm3000fnma4bjjjkgu3	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0014nma4m87kp6kr	cmf7lrsm3000gnma49fzlf6f7	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0015nma4jrifbewo	cmf7lrsm3000hnma4osjtm5bm	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0016nma4om3b0lyk	cmf7lrsm3000inma48ckaufrp	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0017nma4d2ialtx4	cmf7lrsm3000jnma48rl8dy30	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0018nma44jp9nt7r	cmf7lrsm3000knma4lw3wigjn	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli0019nma4a1ho46am	cmf7lrsm3000lnma403na7ufu	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli001anma46cj8cnnl	cmf7lrsm3000mnma43btb5icd	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli001bnma4catundjq	cmf7lrsm3000nnma4z2489rf7	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli001cnma4lrojkjal	cmf7lrsm3000onma4o4jt30ns	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli001dnma48tsffyd1	cmf7lrsm3000pnma4x0rzb630	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lusli001enma4og8n5r2m	cmf7lrsm3000qnma4r6gz3ahq	2025-09-06 01:48:37.062	2025-09-06 01:48:37.062	cmf7lugii000snma48bkhqpw1
cmf7lxisx002onma4o5d4auwl	cmf7lxea5002nnma4yfgnvfs1	2025-09-06 01:50:44.337	2025-09-06 01:50:44.337	cmf7lugii000snma48bkhqpw1
cmf7tkuvl003wnmm87jl5heb0	cmf7thxz70007nmm8lym0k760	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl003xnmm8znd34ql6	cmf7thxz70008nmm8lq5y3min	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl003ynmm8jvtf5r19	cmf7thxz70009nmm8y8ko0t3b	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl003znmm8ufymqzva	cmf7thxz7000anmm8sxaoa0ii	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl0040nmm8imf4gtl4	cmf7thxz7000bnmm89vcuo1yp	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl0041nmm8qmb7bac8	cmf7thxz7000cnmm87kcj3s1s	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl0042nmm891txk2uj	cmf7thxz7000dnmm83hwo3xdm	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl0043nmm8qmzxdnfl	cmf7thxz7000enmm82u3wk65u	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvl0044nmm8gu4nd7qh	cmf7thxz7000fnmm8cmy9sjly	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm0045nmm8c99zmffp	cmf7thxz7000gnmm88mefthxn	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm0046nmm8mfjl02tc	cmf7thxz7000hnmm82sxmhfk7	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm0047nmm83w8dun6u	cmf7thxz7000inmm8efws40ho	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm0048nmm86ubm56yv	cmf7thxz8000jnmm85ammiuv2	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm0049nmm8m481feln	cmf7thxz8000knmm835j5d42h	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004anmm8cdl4np24	cmf7thxz8000lnmm8t36asp2k	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004bnmm8bu26ezpy	cmf7thxz8000mnmm829nq8b1g	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004cnmm8xiinyocw	cmf7thxz8000nnmm8rwjg2ekg	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004dnmm8fy2i2lra	cmf7thxz8000onmm8hobpz4sp	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004enmm8kz9z12ke	cmf7thxz8000pnmm88zqcqr4r	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004fnmm89ee1g0bv	cmf7thxz8000qnmm81gz4lj5c	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004gnmm878ricxe2	cmf7thxz8000rnmm8zi98iil4	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004hnmm8eqqmx9d7	cmf7thxz8000snmm8krh7k9kn	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tkuvm004inmm82uv1n6to	cmf7thxz8000tnmm8sauat03s	2025-09-06 05:24:50.385	2025-09-06 05:24:50.385	cmf7tjl6l001pnmm8ffo04ev2
cmf7tone9004vnmm8hwk5qe2v	cmf7tinog000wnmm8wrcvp1wb	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone9004wnmm8xs5rmv21	cmf7tinog000xnmm8yum3lsjr	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone9004xnmm8i84z2d48	cmf7tinog000ynmm8uypypmzl	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone9004ynmm8vbh9jrvk	cmf7tinog000znmm8yb354l49	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone9004znmm8bs7q0lgl	cmf7tinog0010nmm87t9o072r	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90050nmm8wpycn8pa	cmf7tinog0011nmm8jvzlbom0	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90051nmm8fzxe8t04	cmf7tinog0012nmm81xk6ziv3	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90052nmm8cdy39ts2	cmf7tinog0013nmm89sfcz7m3	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90053nmm8ongg5j7k	cmf7tinog0014nmm8xx0xvaws	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90054nmm8x02we1jx	cmf7tinog0015nmm8xhq4e5u5	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tone90055nmm8hsy2p3sv	cmf7tinog0016nmm8b7ew8k0r	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea0056nmm8124xpuhf	cmf7tinog0017nmm8roqzleim	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea0057nmm8rl4a2fw4	cmf7tinog0018nmm8h6f0wqef	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea0058nmm8rtc6zw1e	cmf7tinog0019nmm8jkjs9ol2	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea0059nmm8ft6mlxx7	cmf7tinog001anmm8zs1aeh2l	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005anmm8rowps1ob	cmf7tinog001bnmm87cyr61k5	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005bnmm8hh9kjrsd	cmf7tinog001cnmm86mkppju7	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005cnmm8nigqi29h	cmf7tinog001dnmm8z1zczlm1	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005dnmm8cjc562bg	cmf7tinog001enmm8wenm9due	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005enmm8whrunvdt	cmf7tinog001fnmm8pojptluw	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005fnmm8tthsjsrd	cmf7tinog001gnmm8od8g4eiu	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005gnmm8nlvhtoqj	cmf7tinog001hnmm8dvnnkvwk	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005hnmm8nfmw97cf	cmf7tinog001inmm8kfk6g419	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005inmm8lgrpn2la	cmf7tinog001jnmm8kbaal5pd	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005jnmm82zvpp915	cmf7tinog001knmm8tj3qyu0d	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005knmm8y5gypl9s	cmf7tinog001lnmm8w9kij5j5	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005lnmm8hvq5j0qq	cmf7tinog001mnmm8q8ev2yc3	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7tonea005mnmm8jh6i7dkv	cmf7tinog001nnmm8gwhs5380	2025-09-06 05:27:47.314	2025-09-06 05:27:47.314	cmf7tkhwy001rnmm8x7y02m3f
cmf7xxn8r007tnmm8202thq4n	cmf7xwgol0063nmm890gwfxrz	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r007unmm81pm8i53q	cmf7xwgol0064nmm889z624wo	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r007wnmm8dqw6rfs9	cmf7xwgol0066nmm8bw92foli	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r007xnmm8f62qymj6	cmf7xwgol0067nmm8pirlycmr	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r007ynmm8zkr3xekn	cmf7xwgol0068nmm89m9x6bus	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r007znmm88wx5snhy	cmf7xwgol0069nmm89vwrvfyg	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0080nmm8gshk99qt	cmf7xwgol006anmm8d6rho3yl	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0081nmm8o5cfodul	cmf7xwgol006bnmm82slhecy4	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0082nmm8xks6urti	cmf7xwgol006cnmm8p7slz9ki	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0083nmm8dp1xp3ks	cmf7xwgol006dnmm8u2cvmin9	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0084nmm8mg3d4usx	cmf7xwgol006enmm8ynae8ks1	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0085nmm8pd78s22i	cmf7xwgol006fnmm84ya5gwfz	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0086nmm8c3n3hb5s	cmf7xwgol006gnmm8ba6x7b5k	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0087nmm836e2zkp1	cmf7xwgol006hnmm87qtugmc3	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0088nmm8dt5slr47	cmf7xwgol006inmm8nmlcleyh	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r0089nmm8nlxwq0cr	cmf7xwgol006jnmm8anajuyg9	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r008anmm8iup6gpm8	cmf7xwgol006knmm8hrmcsmz1	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r008bnmm8upkpyjc5	cmf7xwgol006lnmm8kujp08fe	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r008cnmm8uzvqelb6	cmf7xwgol006mnmm8k56dy17o	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r008dnmm8grsrf4vk	cmf7xwgol006nnmm86r7ptt7u	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf7xxn8r008enmm8pkhrtfjf	cmf7xwgol006onmm8wxn06ayr	2025-09-06 07:26:45.483	2025-09-06 07:26:45.483	cmf7xxbi5006qnmm8gy5bkbcr
cmf82l4du00a8nmm8pl2z2xcs	cmf82kzu3009vnmm8knsfnw8f	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00a9nmm86pzfl33a	cmf82kzu3009wnmm86tn9w95f	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00aanmm8cwqa2ipi	cmf82kzu3009xnmm81y0y71oi	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00acnmm82um3xn6u	cmf82kzu3009znmm8tj8678m7	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00adnmm8wv1sydni	cmf82kzu300a0nmm86d2zw0y8	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00aenmm8ybkuxzr1	cmf82kzu300a1nmm8ngmsm0o4	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00afnmm83zklfi1e	cmf82kzu300a2nmm8mxn5qc3j	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00agnmm8j7tvbbc9	cmf82kzu300a3nmm8wdn0dt9o	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00ahnmm8cqjzjgir	cmf82kzu300a4nmm85ut1408p	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00ainmm8v5uak82g	cmf82kzu300a5nmm8whk6vvuo	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00ajnmm8avf985oi	cmf82kzu300a6nmm81p1lt5u4	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf82l4du00aknmm8jifetvts	cmf82kzu300a7nmm8g8t68aqy	2025-09-06 09:36:59.251	2025-09-06 09:36:59.251	cmf82jp6i008snmm81huf1qgl
cmf834cc800asnmm86dtqy2lh	cmf8348fk00arnmm8noev9pua	2025-09-06 09:51:56.025	2025-09-06 09:51:56.025	cmf82jp6i008snmm81huf1qgl
cmf97kdw5001gnmk8efqdebev	cmf97jsjd0016nmk838ser611	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001hnmk8szpl375a	cmf97jsjd0017nmk8xf1az9wf	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001inmk845da5l88	cmf97jsjd0018nmk87q3w23x1	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001jnmk86tbhypc2	cmf97jsjd0019nmk8prm869r1	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001knmk8aa4w477q	cmf97jsjd001anmk80c0olw7r	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001lnmk8wiitxez6	cmf97jsjd001bnmk8s4hmkf2u	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001mnmk8pmnreza8	cmf97jsjd001cnmk8bwstphut	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001nnmk80ozlcnug	cmf97jsjd001dnmk8qeeqzh23	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001onmk804lfx5cf	cmf97jsjd001enmk8wbh4rr7w	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf97kdw5001pnmk8xfqtcohb	cmf97k7jf001fnmk8od4o0ofe	2025-09-07 04:44:09.174	2025-09-07 04:44:09.174	cmf97ipf90003nmk88v5j9kl5
cmf9f14hp003tnmk8nj4vo47r	cmf9ezsb30022nmk8h2cs5nii	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003unmk8yatjc68v	cmf9ezsb30023nmk82livogwi	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003vnmk8oinf8qwc	cmf9ezsb30024nmk8ggu7033r	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003wnmk8sahldzpg	cmf9ezsb30025nmk8d1x4tmuk	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003xnmk80gj2xmdr	cmf9ezsb30026nmk8eyhxgte9	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003ynmk8rsc0oby4	cmf9ezsb30027nmk8du1w3igw	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp003znmk8gmojb60d	cmf9ezsb30028nmk89yq185ad	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0040nmk8yeqdk4m4	cmf9ezsb30029nmk8l65wdilx	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0041nmk8ivvn71ew	cmf9ezsb3002anmk8dhsnpfqs	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0042nmk8uzrwlkfs	cmf9ezsb3002bnmk896c9qflv	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0043nmk8vohr09k6	cmf9ezsb3002cnmk8m6ti9wcg	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0044nmk8o1tfam5d	cmf9ezsb3002dnmk8h05bg3gf	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0045nmk8149exwlm	cmf9ezsb3002enmk88k449sk9	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0046nmk8w2ngwgcd	cmf9ezsb3002fnmk8clviuhx2	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0047nmk8gwzhjpxh	cmf9ezsb3002gnmk8y0habim5	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0048nmk8oqesej92	cmf9ezsb3002hnmk8e89yhv6c	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp0049nmk8kx5q5cxo	cmf9ezsb3002inmk8pb2u33ab	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004anmk8hvsky1nc	cmf9ezsb3002jnmk80l377nad	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004bnmk81hpq0mws	cmf9ezsb3002knmk8ffmufnv0	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004cnmk8yrxd6i52	cmf9ezsb3002lnmk87bxe1u9n	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004dnmk8qafreq2o	cmf9ezsb3002mnmk8nhryku7h	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004enmk8q1d03qbw	cmf9ezsb3002nnmk8j2pcko8i	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9f14hp004fnmk8s4u9mwcz	cmf9ezsb3002onmk8a1vllvbf	2025-09-07 08:13:07.453	2025-09-07 08:13:07.453	cmf9f0g4s002qnmk8gbjx6pk6
cmf9hpw620065nmk8gmj1g9sm	cmf9hor8t004knmk8poss6do6	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw620066nmk8v8s6lukd	cmf9hor8t004lnmk836rnubj1	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw620067nmk8c1z55vr5	cmf9hor8t004mnmk8owkbid9a	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw620068nmk8yk6a38ng	cmf9hor8t004nnmk87y7fbspd	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw620069nmk8v92funqg	cmf9hor8t004onmk87htjzl40	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006anmk81mayobk0	cmf9hor8t004pnmk8qnfosz0z	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006bnmk8pzynxke3	cmf9hor8t004qnmk8lbgurfvd	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006cnmk8h2kmxb5f	cmf9hor8t004rnmk884660ob2	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006dnmk8t93ao6e0	cmf9hor8t004snmk8dip84uhg	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006enmk8u6i5z88n	cmf9hor8t004tnmk8soxwkfqa	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006fnmk8vmkc4qm4	cmf9hor8t004unmk81bhme172	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006gnmk8g8upqwep	cmf9hor8t004vnmk8v4qrsnbu	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006hnmk80qw9vc8v	cmf9hor8t004wnmk8oajlhups	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006inmk8qmkcjp40	cmf9hor8t004xnmk8hwn21qqx	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006jnmk886iw7f02	cmf9hor8t004ynmk8k32ct9in	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006knmk86d94rhw6	cmf9hor8t004znmk88o9989lx	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9hpw62006lnmk8yypmite4	cmf9hor8t0050nmk8ptyo53s8	2025-09-07 09:28:22.298	2025-09-07 09:28:22.298	cmf9hpjss0052nmk8vxs37mw3
cmf9l348i008dnmk89a884yf5	cmf9l1x8s006onmk8byp1geao	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348i008enmk8tnts7l7r	cmf9l1x8s006pnmk82i1fsukx	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008fnmk8j5qidlmr	cmf9l1x8s006qnmk8rcxkld9p	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008gnmk8pn26ckeb	cmf9l1x8s006rnmk884yq5nos	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008hnmk85qya6x7c	cmf9l1x8s006snmk8wiotw04m	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008inmk8re8q772l	cmf9l1x8s006tnmk8cxv4gir3	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008jnmk8ojg2t21o	cmf9l1x8s006unmk8dwnnll68	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008knmk8l8hbu3d7	cmf9l1x8s006vnmk8lpi75za1	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008lnmk85ttehbtp	cmf9l1x8s006wnmk85v841low	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008mnmk8qcqzalcb	cmf9l1x8s006xnmk8fnti8n2e	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008nnmk8oofjgt2f	cmf9l1x8s006ynmk8lebzg2gl	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008onmk808ic9qlo	cmf9l1x8s006znmk8azzvyuo0	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008pnmk8jo7ousdx	cmf9l1x8s0070nmk8zjcl5bai	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008qnmk85j87k0vd	cmf9l1x8s0071nmk8tmyod8nl	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008rnmk8dqmd6rfd	cmf9l1x8s0072nmk8ruhtxqrl	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008snmk8z5jzr57t	cmf9l1x8s0073nmk82zb3lw4u	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008tnmk83fzacf4v	cmf9l1x8s0074nmk8w6a55jgm	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008unmk8tl2fzgvd	cmf9l1x8s0075nmk8dh35ipr7	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008vnmk8inionwjg	cmf9l1x8s0076nmk8n7yc040s	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008wnmk893weed6h	cmf9l1x8s0077nmk8w70teys2	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
cmf9l348j008xnmk8fxbcpxp5	cmf9l1x8s0078nmk8t35nd1fe	2025-09-07 11:02:38.131	2025-09-07 11:02:38.131	cmf9l2lvq007anmk885i0xh87
\.


--
-- Data for Name: Semester; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Semester" (id, "teacherId", name, "createdAt", "updatedAt") FROM stdin;
cmf6da27p0003nmzcy53ip9gw	cmf5kt0v30000nmjwygw2gw2z	2025秋	2025-09-05 05:00:46.641	2025-09-05 05:00:46.641
cmf71tw0p0009nmw82u3c1pgk	cmf5kt0v30000nmjwygw2gw2z	2025寒假	2025-09-05 16:28:02.519	2025-09-05 16:28:02.519
cmf7lmgh70002nma45axikkuz	cmf7llf0t0000nma4r3ymsb1x	2025秋季	2025-09-06 01:42:08.107	2025-09-06 01:42:08.107
cmf7tgpcg0004nmm833b2a2q3	cmf7tg2wg0002nmm8za4p7xuq	2025秋季	2025-09-06 05:21:36.592	2025-09-06 05:21:36.592
\.


--
-- Data for Name: Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Student" (id, name, phone, note, "createdAt", "updatedAt", "classId") FROM stdin;
cmf6pcv890000nmw8c3anrz1f	Alice	\N	\N	2025-09-05 10:38:52.954	2025-09-05 10:38:52.954	cmf6d8vod0001nmzcsrz1nrpn
cmf6pcv890001nmw84t19zpen	Bob	\N	\N	2025-09-05 10:38:52.954	2025-09-05 10:38:52.954	cmf6d8vod0001nmzcsrz1nrpn
cmf6pcv890002nmw86w5vhhwy	Charlie	\N	\N	2025-09-05 10:38:52.954	2025-09-05 10:38:52.954	cmf6d8vod0001nmzcsrz1nrpn
cmf71byid0006nmw8hnx1k838	Hachimi	\N	\N	2025-09-05 16:14:05.94	2025-09-05 16:14:05.94	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000anm0kpsy4jsxs	a	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000bnm0kzt9umixe	b	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000cnm0ke37hanyn	c	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000dnm0krmbd3nwt	d	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000enm0k2o7jj5ee	e	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000fnm0kl85i0s0q	f	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000gnm0kclu068cy	g	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000hnm0kjzib5b82	h	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000inm0k4wm0kuff	i	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000jnm0kicz22j7g	j	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000knm0kmdm1ucwk	k	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000lnm0k0ywxdk7j	l	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000mnm0kr6c4uzwq	m	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000nnm0kagh50sdy	n	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000onm0k9yca1dr0	o	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000pnm0klybdty2b	p	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000qnm0kw1hlrdsi	q	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000rnm0k61v68s1n	r	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000snm0kj5y0ith6	s	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf74bbsd000tnm0knurv14at	t	\N	\N	2025-09-05 17:37:35.341	2025-09-05 17:37:35.341	cmf6d8vod0001nmzcsrz1nrpn
cmf7lrsm30005nma4uc15qu7q	Nancy	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm30006nma4v909bnp2	Blue	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm30007nma4zfmeyhfe	Haman	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm30008nma4u20zai29	Carrie	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm30009nma4qyyxmcc9	Jacky	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000anma42sx7mv5v	Derick	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000bnma4obewzbx0	Edison	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000cnma400uoyo57	Peter	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000dnma4o6p5b46p	Elena	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000fnma4bjjjkgu3	Hugh	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000gnma49fzlf6f7	Bob	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000hnma4osjtm5bm	Martin	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000inma48ckaufrp	Penny	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000jnma48rl8dy30	Amy	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000knma4lw3wigjn	Susan	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000lnma403na7ufu	Tommy	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000mnma43btb5icd	Ivy	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000nnma4z2489rf7	David	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000onma4o4jt30ns	Steven	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000pnma4x0rzb630	Sally	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000qnma4r6gz3ahq	Gary	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:46:17.116	cmf7lmw5m0004nma4r49aqtkd
cmf7lrsm3000enma42uvea5ju	ZoeOne	\N	\N	2025-09-06 01:46:17.116	2025-09-06 01:50:29.192	cmf7lmw5m0004nma4r49aqtkd
cmf7lxea5002nnma4yfgnvfs1	ZoeTwo	\N	\N	2025-09-06 01:50:38.477	2025-09-06 01:50:38.477	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk003znma463b21rod	Bill	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0040nma4268uvccz	Birlin	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0041nma4cwic3mvq	Cherry	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0042nma4tg18qvc3	Chuckie	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0043nma4mo9dgev7	Eason	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0044nma49b10wl3v	Elsa	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0045nma4r7w36yyb	Garry	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0046nma4t7gou3gt	Hannah	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0047nma4au49mhrh	Hency	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0048nma4a32xk5xj	Jasmine	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk0049nma4bzx99juh	Jessie	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004anma4xb4a0hh8	Judy	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004bnma44iz32t8u	Leon	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004cnma4vi99w8vi	LeoNew	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004dnma4ngbd3lfa	LeoOld	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004enma4fammvcbm	Liliya	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004fnma4auxhylka	Lisa	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004gnma4re5yezm7	LucasLiao	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004hnma4cz7kmkr0	LucasChen	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004inma41xrg3b54	Luna	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004jnma4k51e4jga	Percy	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004knma400gcp7rs	Roy	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004lnma4cu7i4emc	Sharon	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004mnma4n7l8w9zr	Terry	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004nnma4c04soxvn	Wendy	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004onma4ehdl57g4	Wick	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pexmk004pnma49gniqd4n	Will	\N	\N	2025-09-06 03:28:15.548	2025-09-06 03:28:15.548	cmf7lmw5m0004nma4r49aqtkd
cmf7pn3lc005rnma4hvs7hvey	Alice	\N	\N	2025-09-06 03:34:36.528	2025-09-06 03:34:36.528	cmf7lmw5m0004nma4r49aqtkd
cmf7pwhay005tnma4p3v0hzql	Kobe	\N	\N	2025-09-06 03:41:54.203	2025-09-06 03:41:54.203	cmf7lmw5m0004nma4r49aqtkd
cmf7qonjz0002nm28ml652psd	Bill	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0003nm28qi9pvpyn	Birlin	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0004nm288wdv9li5	Cherry	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0005nm28fdzno14c	Chuckie	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0006nm28fz3s3waj	Eason	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0007nm28faagc0ud	Elsa	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0008nm28u9pm9rnj	Garry	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz0009nm28qzvf8woe	Hannah	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000anm28ytuajl4l	Hency	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000bnm2894vfvnou	Jacky	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000cnm286lnpotfw	Jasmine	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000dnm28xp519cdq	Jessie	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000enm28w96bdwtd	Judy	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000fnm28xmye8f8h	Leon	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000gnm28fjls33ro	LeoNew	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000hnm2814qw5qs0	LeoOld	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000inm2884oyinxg	Liliya	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000jnm28iwl423oh	Lisa	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000knm28gms21047	LucasLiao	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000lnm28nxv4qzc7	LucasChen	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000mnm28pzu9cwoq	Luna	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000nnm28lzjwnvuw	Percy	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000onm283p3pf9hi	Roy	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000pnm286s584cfj	Sharon	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000qnm28zeuprao9	Terry	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000rnm285rcrzvd6	Wendy	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000snm28578tdj8j	Wick	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7qonjz000tnm28oh899uff	Will	\N	\N	2025-09-06 04:03:48.671	2025-09-06 04:03:48.671	cmf6d8vod0001nmzcsrz1nrpn
cmf7rtpzt000unm28r4j1qllv	test	\N	\N	2025-09-06 04:35:44.73	2025-09-06 04:35:44.73	cmf6d8vod0001nmzcsrz1nrpn
cmf7rwe6o000vnm28obg8ly14	man	\N	\N	2025-09-06 04:37:49.393	2025-09-06 04:37:49.393	cmf6d8vod0001nmzcsrz1nrpn
cmf7s1dzh000wnm28i0embbkt	MAN	\N	\N	2025-09-06 04:41:42.413	2025-09-06 04:41:42.413	cmf6d8vod0001nmzcsrz1nrpn
cmf7s8jcp0000nmm8gs6qse32	bro	\N	\N	2025-09-06 04:47:15.961	2025-09-06 04:47:15.961	cmf6d8vod0001nmzcsrz1nrpn
cmf7te0fe0001nmm8hdps05b1	what	\N	\N	2025-09-06 05:19:30.986	2025-09-06 05:19:30.986	cmf7qo3as0001nm28okecxr6p
cmf7thxz70007nmm8lym0k760	Nancy	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz70008nmm8lq5y3min	Blue	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz70009nmm8y8ko0t3b	Haman	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000anmm8sxaoa0ii	Carrie	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000bnmm89vcuo1yp	Jacky	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000cnmm87kcj3s1s	Derick	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000dnmm83hwo3xdm	Edison	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000enmm82u3wk65u	Peter	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000fnmm8cmy9sjly	Elena	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000gnmm88mefthxn	ZoeOne	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000hnmm82sxmhfk7	Hugh	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz7000inmm8efws40ho	Bob	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000jnmm85ammiuv2	ZoeTwo	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000knmm835j5d42h	Martin	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000lnmm8t36asp2k	Penny	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000mnmm829nq8b1g	Amy	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000nnmm8rwjg2ekg	Susan	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000onmm8hobpz4sp	Tommy	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000pnmm88zqcqr4r	Ivy	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000qnmm81gz4lj5c	David	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000rnmm8zi98iil4	Steven	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000snmm8krh7k9kn	Sally	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7thxz8000tnmm8sauat03s	Gary	\N	\N	2025-09-06 05:22:34.436	2025-09-06 05:22:34.436	cmf7th28w0006nmm80tv70z6b
cmf7tinog000wnmm8wrcvp1wb	Bill	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog000xnmm8yum3lsjr	Birlin	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog000ynmm8uypypmzl	Cherry	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog000znmm8yb354l49	Chuckie	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0010nmm87t9o072r	Eason	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0011nmm8jvzlbom0	Elsa	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0012nmm81xk6ziv3	Garry	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0013nmm89sfcz7m3	Hannah	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0014nmm8xx0xvaws	Hency	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0015nmm8xhq4e5u5	Jacky	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0016nmm8b7ew8k0r	Jasmine	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0017nmm8roqzleim	Jessie	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0018nmm8h6f0wqef	Judy	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog0019nmm8jkjs9ol2	Leon	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001anmm8zs1aeh2l	LeoNew	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001bnmm87cyr61k5	LeoOld	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001cnmm86mkppju7	Liliya	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001dnmm8z1zczlm1	Lisa	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001enmm8wenm9due	LucasLiao	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001fnmm8pojptluw	LucasChen	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001gnmm8od8g4eiu	Luna	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001hnmm8dvnnkvwk	Percy	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001inmm8kfk6g419	Roy	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001jnmm8kbaal5pd	Sharon	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001knmm8tj3qyu0d	Terry	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001lnmm8w9kij5j5	Wendy	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001mnmm8q8ev2yc3	Wick	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7tinog001nnmm8gwhs5380	Will	\N	\N	2025-09-06 05:23:07.744	2025-09-06 05:23:07.744	cmf7tie4k000vnmm81jb31fpz
cmf7xwgol0063nmm890gwfxrz	HannaWeng	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol0064nmm889z624wo	Peter	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol0066nmm8bw92foli	Summer	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol0067nmm8pirlycmr	Cindy	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol0068nmm89m9x6bus	Vicky	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol0069nmm89vwrvfyg	Sunny	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006anmm8d6rho3yl	FionaFan	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006bnmm82slhecy4	Charlie	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006cnmm8p7slz9ki	Jojo	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006dnmm8u2cvmin9	Shown	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006enmm8ynae8ks1	Angel	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006fnmm84ya5gwfz	Aaron	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006gnmm8ba6x7b5k	Chloe	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006hnmm87qtugmc3	Kathy	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006inmm8nmlcleyh	Mike	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006jnmm8anajuyg9	FionaTwo	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006knmm8hrmcsmz1	Ina	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006lnmm8kujp08fe	Alice	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006mnmm8k56dy17o	Kimmy	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006nnmm86r7ptt7u	Julian	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf7xwgol006onmm8wxn06ayr	Ronaldo	\N	\N	2025-09-06 07:25:50.325	2025-09-06 07:25:50.325	cmf7xw3o20062nmm8d35vvkob
cmf82kzu3009vnmm8knsfnw8f	Lily	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu3009wnmm86tn9w95f	Sherry	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu3009xnmm81y0y71oi	Hanson	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu3009znmm8tj8678m7	SunnyTwo	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a0nmm86d2zw0y8	Eason	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a1nmm8ngmsm0o4	Wendy	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a2nmm8mxn5qc3j	JennyYe	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a3nmm8wdn0dt9o	Rick	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a4nmm85ut1408p	Henry	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a5nmm8whk6vvuo	Neil	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a6nmm81p1lt5u4	Amy	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf82kzu300a7nmm8g8t68aqy	Gerry	\N	\N	2025-09-06 09:36:53.355	2025-09-06 09:36:53.355	cmf82ixo4008qnmm8d7wud1sd
cmf8348fk00arnmm8noev9pua	Cera	\N	\N	2025-09-06 09:51:50.96	2025-09-06 09:51:50.96	cmf82ixo4008qnmm8d7wud1sd
cmf97jsjd0016nmk838ser611	Nemo	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd0017nmk8xf1az9wf	Frank	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd0018nmk87q3w23x1	Emily	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd0019nmk8prm869r1	Sammy	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd001anmk80c0olw7r	Seven	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd001bnmk8s4hmkf2u	Michael	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd001cnmk8bwstphut	Freddie	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd001dnmk8qeeqzh23	Oscar	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97jsjd001enmk8wbh4rr7w	Mandy	\N	\N	2025-09-07 04:43:41.498	2025-09-07 04:43:41.498	cmf9722ms0001nmk8m0nhor05
cmf97k7jf001fnmk8od4o0ofe	Angel	\N	\N	2025-09-07 04:44:00.939	2025-09-07 04:44:00.939	cmf9722ms0001nmk8m0nhor05
cmf9ezsb30022nmk8h2cs5nii	Jimmy	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30023nmk82livogwi	Hanna	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30024nmk8ggu7033r	Jessica	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30025nmk8d1x4tmuk	Judy	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30026nmk8eyhxgte9	Gary	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30027nmk8du1w3igw	Jeff	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30028nmk89yq185ad	Jason	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb30029nmk8l65wdilx	Yoky	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002anmk8dhsnpfqs	Peter	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002bnmk896c9qflv	RebeccaNew	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002cnmk8m6ti9wcg	JoeyOne	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002dnmk8h05bg3gf	Tammy	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002enmk88k449sk9	Celina	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002fnmk8clviuhx2	Sally	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002gnmk8y0habim5	Tina	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002hnmk8e89yhv6c	JoeyTwo	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002inmk8pb2u33ab	Zoe	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002jnmk80l377nad	William	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002knmk8ffmufnv0	Harry	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002lnmk87bxe1u9n	Hans	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002mnmk8nhryku7h	Hanson	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002nnmk8j2pcko8i	Mickey	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9ezsb3002onmk8a1vllvbf	RebeccaOld	\N	\N	2025-09-07 08:12:05.008	2025-09-07 08:12:05.008	cmf9exch6001tnmk8iz4ozfxy
cmf9hor8t004knmk8poss6do6	Danny	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004lnmk836rnubj1	Peter	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004mnmk8owkbid9a	Doris	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004nnmk87y7fbspd	Max	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004onmk87htjzl40	Jenny	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004pnmk8qnfosz0z	Eason	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004qnmk8lbgurfvd	Amy	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004rnmk884660ob2	Happy	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004snmk8dip84uhg	Fort	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004tnmk8soxwkfqa	Rumos	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004unmk81bhme172	Lauren	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004vnmk8v4qrsnbu	Scott	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004wnmk8oajlhups	Candy	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004xnmk8hwn21qqx	Michael	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004ynmk8k32ct9in	Yoky	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t004znmk88o9989lx	Elsa	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9hor8t0050nmk8ptyo53s8	Anny	\N	\N	2025-09-07 09:27:29.261	2025-09-07 09:27:29.261	cmf9hoj6e004jnmk8dt3nd4xg
cmf9l1x8s006onmk8byp1geao	Leo 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006pnmk82i1fsukx	Young 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006qnmk8rcxkld9p	Sandy 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006rnmk884yq5nos	Joey 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006snmk8wiotw04m	Mia 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006tnmk8cxv4gir3	Zoe	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006unmk8dwnnll68	Mark	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006vnmk8lpi75za1	Jenny	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006wnmk85v841low	Alex 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006xnmk8fnti8n2e	Eason 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006ynmk8lebzg2gl	Joyce	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s006znmk8azzvyuo0	Nancy 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0070nmk8zjcl5bai	Emily	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0071nmk8tmyod8nl	Miracle 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0072nmk8ruhtxqrl	Molly	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0073nmk82zb3lw4u	Vicky	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0074nmk8w6a55jgm	Edison 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0075nmk8dh35ipr7	Lisa	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0076nmk8n7yc040s	Will	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0077nmk8w70teys2	Lucas	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
cmf9l1x8s0078nmk8t35nd1fe	Nina 	\N	\N	2025-09-07 11:01:42.412	2025-09-07 11:01:42.412	cmf9l0u2q006nnmk81pjfrj4m
\.


--
-- Data for Name: Teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Teacher" (id, email, name, "createdAt", "updatedAt", "passwordHash") FROM stdin;
cmf5kt0v30000nmjwygw2gw2z	2935630783@qq.com	张老师	2025-09-04 15:43:42.496	2025-09-04 15:43:42.496	$2b$12$lc9IjaFpeeQ7lS737B0oM.Njt.VBsN4JURh1f2Qbe7bU//4OUjKee
cmf7llf0t0000nma4r3ymsb1x	lucy@lucy.lucy	lucy	2025-09-06 01:41:19.563	2025-09-06 01:41:19.563	$2b$12$4mS4dP4y67KpIg5RmInIheejb.cmEvzRHUjAwLGpQI8X92M23vdGW
cmf7tg2wg0002nmm8za4p7xuq	lucy@lucy.service	lucylucy	2025-09-06 05:21:07.503	2025-09-06 05:21:07.503	$2b$12$WiyMbU02yemFVefzqjkK..YgG1SMZ51ojnqwLQgS77vaepzN8ZPyi
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
ebe8b6d6-1edb-433c-b2b6-99ca5b39fbc7	a16ca36cea9c7488c169c2211ac43bec5cb2ba7ea4464cfa7f349291cd2ab850	2025-09-04 23:28:46.872733+08	20250904152846_init	\N	\N	2025-09-04 23:28:46.836508+08	1
d05ca554-4f3b-45c0-952b-dbce8cec5d10	00888273e9cfd682ad8d27e9ff8a69bea6547d71d8cb8cbd3d4ac1caebfbe5b4	2025-09-04 23:33:07.733429+08	20250904153307_auth_add_password_to_teacher	\N	\N	2025-09-04 23:33:07.726338+08	1
791b97dd-daa0-4330-8112-3bcd3f1e30ca	1751ca13c8d655743e9f778d713c91731b30e6579022aa616dfacda86309d7f2	2025-09-05 00:30:22.81227+08	20250904163022_reshape_term_model	\N	\N	2025-09-05 00:30:22.775858+08	1
161d2408-3baa-4bb7-b0fb-12e24ea87aa1	54de7769662784e06fd45fb8c29a9722e6c349ffb4441ec79c9d70b606085f63	2025-09-05 18:25:17.650976+08	20250905102517_student_belongs_to_class	\N	\N	2025-09-05 18:25:17.6358+08	1
\.


--
-- Name: Absence Absence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Absence"
    ADD CONSTRAINT "Absence_pkey" PRIMARY KEY (id);


--
-- Name: ClassSession ClassSession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassSession"
    ADD CONSTRAINT "ClassSession_pkey" PRIMARY KEY (id);


--
-- Name: ClassTerm ClassTerm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassTerm"
    ADD CONSTRAINT "ClassTerm_pkey" PRIMARY KEY (id);


--
-- Name: Class Class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Class"
    ADD CONSTRAINT "Class_pkey" PRIMARY KEY (id);


--
-- Name: Enrollment Enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_pkey" PRIMARY KEY (id);


--
-- Name: Semester Semester_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Semester"
    ADD CONSTRAINT "Semester_pkey" PRIMARY KEY (id);


--
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);


--
-- Name: Teacher Teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teacher"
    ADD CONSTRAINT "Teacher_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Absence_sessionId_studentId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Absence_sessionId_studentId_key" ON public."Absence" USING btree ("sessionId", "studentId");


--
-- Name: ClassSession_classTermId_date_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ClassSession_classTermId_date_key" ON public."ClassSession" USING btree ("classTermId", date);


--
-- Name: ClassTerm_classId_semesterId_startDate_endDate_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ClassTerm_classId_semesterId_startDate_endDate_key" ON public."ClassTerm" USING btree ("classId", "semesterId", "startDate", "endDate");


--
-- Name: Class_teacherId_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Class_teacherId_name_key" ON public."Class" USING btree ("teacherId", name);


--
-- Name: Enrollment_studentId_classTermId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Enrollment_studentId_classTermId_key" ON public."Enrollment" USING btree ("studentId", "classTermId");


--
-- Name: Semester_teacherId_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Semester_teacherId_name_key" ON public."Semester" USING btree ("teacherId", name);


--
-- Name: Student_classId_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Student_classId_name_key" ON public."Student" USING btree ("classId", name);


--
-- Name: Teacher_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Teacher_email_key" ON public."Teacher" USING btree (email);


--
-- Name: Absence Absence_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Absence"
    ADD CONSTRAINT "Absence_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."ClassSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Absence Absence_studentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Absence"
    ADD CONSTRAINT "Absence_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClassSession ClassSession_classTermId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassSession"
    ADD CONSTRAINT "ClassSession_classTermId_fkey" FOREIGN KEY ("classTermId") REFERENCES public."ClassTerm"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClassTerm ClassTerm_classId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassTerm"
    ADD CONSTRAINT "ClassTerm_classId_fkey" FOREIGN KEY ("classId") REFERENCES public."Class"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClassTerm ClassTerm_semesterId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClassTerm"
    ADD CONSTRAINT "ClassTerm_semesterId_fkey" FOREIGN KEY ("semesterId") REFERENCES public."Semester"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Class Class_teacherId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Class"
    ADD CONSTRAINT "Class_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES public."Teacher"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Enrollment Enrollment_classTermId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_classTermId_fkey" FOREIGN KEY ("classTermId") REFERENCES public."ClassTerm"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Enrollment Enrollment_studentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Semester Semester_teacherId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Semester"
    ADD CONSTRAINT "Semester_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES public."Teacher"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Student Student_classId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_classId_fkey" FOREIGN KEY ("classId") REFERENCES public."Class"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict NdGQ2VK2fMG2THGtN1dHEBdkWIXXH15urGwWlnmNpbz3abdwxkONY4aSXsWJBPe

