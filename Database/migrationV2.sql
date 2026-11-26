/*
 This file will add descriptions to the database
 */

 use cweb_280_project;

alter table issues
add column IssueDescription text
after TypeOfIssue;

describe Issues;