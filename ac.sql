CREATE TABLE call (
  id int  NOT NULL IDENTITY(1, 1),
  employee_id int  NOT NULL,
  customer_id int  NOT NULL,
  start_time datetime  NOT NULL,
  end_time datetime  NULL,
  call_outcome_id int  NULL,
  CONSTRAINT call_ak_1 UNIQUE (employee_id, start_time),
  CONSTRAINT call_pk PRIMARY KEY  (id)
);