module Main (..) where

import Task
import Console
import ElmTest exposing (..)

import GradeSchool as S exposing (..)

import Dict

tests : Test
tests = suite "GradeSchool Test Suite"
        [
        test "add student" (assertEqual [(2, ["Aimee"])]
          (S.schoolToList (S.addStudent 2 "Aimee" S.newSchool))),
        test "add more students in same class" (assertEqual [(2, ["Blair", "James", "Paul"])]
          (S.schoolToList (S.gradeWithStudents 2 ["James", "Blair", "Paul"]))),
        test "add students to different grades" (assertEqual [(3, ["Chelsea"]), (7, ["Logan"])]
          (S.schoolToList (S.schoolFromList [(3, "Chelsea"), (7, "Logan")]))),
        test "get students in a grade" (assertEqual ["Bradley", "Franklin"]
          (S.studentsInGrade 5 (S.schoolFromList [(5, "Franklin"), (5, "Bradley"), (1, "Jeff")]))),
        test "get students in a non-existent grade" (assertEqual [] (S.studentsInGrade 1 S.newSchool))
        ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
