# EduShare Content Creation Guide

Guide for teachers and educators creating learning materials for EduShare.

---

## Table of Contents

1. [Content Philosophy](#content-philosophy)
2. [File Format](#file-format)
3. [Formatting Guidelines](#formatting-guidelines)
4. [Content Structure](#content-structure)
5. [Best Practices](#best-practices)
6. [Examples](#examples)
7. [Adding Content](#adding-content)

---

## Content Philosophy

### Design Principles

EduShare materials should be:

- **Simple**: Easy to understand, age-appropriate language
- **Self-contained**: Each lesson covers one topic completely
- **Practical**: Real-world examples and applications
- **Engaging**: Interactive elements, practice problems
- **Accessible**: Works on any terminal, no special formatting required

### Target Audience

Content is designed for:
- Students aged 10-18
- Self-paced learning
- Low-bandwidth environments
- Terminal-only displays (80 characters wide recommended)

---

## File Format

### Basic Requirements

- **Format**: Plain text (.txt files)
- **Encoding**: UTF-8
- **Line length**: Recommended maximum 76 characters
- **Line endings**: Unix format (LF, not CRLF)

### File Naming Convention

```
[number]_[topic_name].txt

Examples:
01_basic_arithmetic.txt
02_multiplication.txt
03_division.txt
10_advanced_algebra.txt
```

**Rules:**
- Use leading zeros (01, 02, not 1, 2)
- Use lowercase
- Use underscores for spaces
- Use descriptive names
- Numbers indicate sequence/difficulty

---

## Formatting Guidelines

### Title Formatting

```
================================================================================
                           LESSON TITLE HERE
================================================================================
```

- 80 equals signs (=) for top and bottom borders
- Title centered and in CAPS
- Leave blank lines before and after

### Section Headers

```
Section Name
------------
```

or

```
SECTION NAME:
-------------
```

- Title case or ALL CAPS with colon
- Underline with dashes (-) matching title length

### Subsections

```
What is Addition?
-----------------
```

- Question format works well
- Keep concise and descriptive

### Bullet Points

```
Key Points:
-----------
* Point one
* Point two
* Point three
```

or

```
Important Facts:
- Fact one
- Fact two
- Fact three
```

### Numbered Lists

```
Steps to Follow:
1. First step
2. Second step
3. Third step
```

### Examples Section

```
Examples:
  3 + 2 = 5    (three plus two equals five)
  10 + 5 = 15  (ten plus five equals fifteen)
```

- Indent with 2-4 spaces
- Include explanations in parentheses when helpful

### Practice Problems

```
Practice Problems:
------------------
1. 5 + 4 = ?
2. 12 - 7 = ?
3. 8 + 6 = ?

Answers: 1) 9  2) 5  3) 14
```

- Always include answers
- Separate answers from questions

### Visual Elements

Use ASCII art when helpful:

```
The Water Cycle:

    [Clouds]
       ↓
  ╔════════════╗
  ║   Rain     ║
  ╚════════════╝
       ↓
  [Ocean/Lake]
       ↑
  (Evaporation)
```

Keep it simple - complex drawings may not render well on all terminals.

---

## Content Structure

### Standard Lesson Template

```
================================================================================
                           [LESSON TITLE]
================================================================================

LESSON [N]: [Subtitle]
----------------------

Introduction/Overview
---------------------
Brief introduction to the topic (2-3 sentences).


Main Content Section 1
-----------------------
Detailed explanation of first concept.

Examples:
  Example 1
  Example 2

Real-life Application:
  How this applies in real world...


Main Content Section 2
-----------------------
Detailed explanation of second concept.


Practice Problems
-----------------
1. Question 1
2. Question 2
3. Question 3

Answers: 1) Ans1  2) Ans2  3) Ans3


Key Points to Remember
-----------------------
* Most important point 1
* Most important point 2
* Most important point 3


[Optional] Fun Facts
--------------------
* Interesting fact 1
* Interesting fact 2

================================================================================
```

### Recommended Sections

Every lesson should include:
1. **Title** - Clear, descriptive
2. **Introduction** - What will be learned
3. **Main Content** - 2-4 major concepts
4. **Examples** - At least 3-5 practical examples
5. **Practice** - Questions for self-assessment
6. **Summary** - Key takeaways

Optional sections:
- Fun Facts
- Historical Context
- Advanced Topics (for quick learners)
- Additional Resources

---

## Best Practices

### Writing Style

**DO:**
- Use clear, simple language
- Define technical terms when first used
- Break complex topics into smaller sections
- Use consistent formatting throughout
- Include practical examples
- Provide immediate feedback (answers)

**DON'T:**
- Use overly complex vocabulary
- Assume prior knowledge without review
- Create walls of text without breaks
- Mix formatting styles
- Skip examples or practice problems

### Length Guidelines

- **Total lesson**: 200-400 lines (fits in most terminals with scrolling)
- **Sections**: 20-40 lines each
- **Paragraphs**: 3-7 lines maximum
- **Examples**: 1-2 lines each

### Difficulty Progression

```
01_filename.txt  →  Basic introduction
02_filename.txt  →  Build on basics
03_filename.txt  →  Intermediate concepts
04_filename.txt  →  Advanced applications
```

Number files to indicate progression.

### Accessibility

- **Reading level**: Aim for grade level or one below
- **Visual elements**: Keep simple, use text descriptions
- **Color**: Don't rely on color (terminal colors vary)
- **Layout**: Works on 80-character terminals

---

## Examples

### Example 1: Mathematics Lesson

```
================================================================================
                           FRACTIONS BASICS
================================================================================

LESSON 3: Understanding Fractions
----------------------------------

What is a Fraction?
-------------------
A fraction represents part of a whole. It's written with two numbers:
  - Top number (numerator): How many parts we have
  - Bottom number (denominator): How many parts make the whole

Examples:
  1/2  →  One half (1 part out of 2)
  3/4  →  Three fourths (3 parts out of 4)
  2/5  →  Two fifths (2 parts out of 5)


Visualizing Fractions
----------------------
Imagine a pizza cut into 4 equal slices:

  ╔═══════╗
  ║ 1 | 2 ║    If you eat 1 slice, you ate 1/4
  ║───┼───║    If you eat 2 slices, you ate 2/4 (or 1/2)
  ║ 3 | 4 ║    If you eat all 4 slices, you ate 4/4 (or 1 whole)
  ╚═══════╝


Practice Problems
-----------------
1. If a cake is cut into 8 pieces and you eat 3, what fraction did you eat?
2. Which is bigger: 1/2 or 1/4?
3. What fraction represents the whole pizza?

Answers: 1) 3/8  2) 1/2  3) 4/4 or 1


Key Points
----------
* Numerator = parts we have
* Denominator = total parts
* Bigger denominator = smaller pieces

================================================================================
```

### Example 2: Science Lesson

```
================================================================================
                        PHOTOSYNTHESIS
================================================================================

LESSON 2: How Plants Make Food
-------------------------------

What is Photosynthesis?
-----------------------
Photosynthesis is the process plants use to make their own food using
sunlight, water, and carbon dioxide (CO2) from the air.


The Photosynthesis Equation
----------------------------
  Sunlight + Water + CO2  →  Glucose (sugar) + Oxygen

  Plants take in:           Plants produce:
  - Sunlight (energy)       - Glucose (food)
  - Water (from roots)      - Oxygen (we breathe!)
  - CO2 (from air)


Where Does It Happen?
---------------------
Inside the leaves, in special cells called chloroplasts.
Chloroplasts contain chlorophyll (the green pigment).


Why Are Leaves Green?
---------------------
Chlorophyll absorbs red and blue light, but reflects green light.
That's why leaves appear green to our eyes!


Practice Questions
------------------
1. What three things do plants need for photosynthesis?
2. What two things do plants produce?
3. Why are most leaves green?

Answers:
1) Sunlight, water, and carbon dioxide (CO2)
2) Glucose (sugar) and oxygen
3) Because chlorophyll reflects green light


Key Points
----------
* Photosynthesis = how plants make food
* Happens in leaves (chloroplasts)
* Produces oxygen we breathe
* Requires sunlight, water, CO2

================================================================================
```

---

## Adding Content

### Step 1: Create the Content File

```bash
# Create new lesson file
nano my-new-lesson.txt

# Follow the template structure
# Save when done
```

### Step 2: Add to Repository

```bash
# Using the content management script
./add-content.sh add-lesson mathematics my-new-lesson.txt

# Or manually
cp my-new-lesson.txt materials/mathematics/lessons/
```

### Step 3: Test the Lesson

```bash
# Run EduShare
./learn.sh

# Navigate to your subject
# Select your new lesson
# Check formatting and readability
```

### Step 4: Review Checklist

Before finalizing content:

- [ ] Title is clear and descriptive
- [ ] Content is age-appropriate
- [ ] Examples are practical and relatable
- [ ] Practice problems included with answers
- [ ] Key points summarized
- [ ] Line length ≤ 76 characters
- [ ] Formatting is consistent
- [ ] Spelling and grammar checked
- [ ] Tested in actual interface

---

## Subject-Specific Guidelines

### Mathematics
- Always show step-by-step solutions
- Include visual representations when possible
- Progress from simple to complex
- Relate to real-world scenarios

### Science
- Use analogies and comparisons
- Include diagrams (ASCII art)
- Explain "why" not just "what"
- Add fun facts to maintain interest

### English/Language
- Provide plenty of examples
- Include sentence construction guides
- Show common mistakes to avoid
- Add reading practice

### History/Social Studies
- Tell stories, not just facts
- Include timelines
- Connect to present day
- Add context and significance

---

## Quality Standards

### Readability

- **Flesch Reading Ease**: Aim for 60-70 (fairly easy to read)
- **Grade Level**: Match to target audience
- **Sentence Length**: Average 15-20 words
- **Paragraph Length**: 3-5 sentences

### Accuracy

- Fact-check all information
- Use reliable sources
- Avoid oversimplification that causes errors
- Have content reviewed by subject expert

### Engagement

- Start with a hook (interesting question or fact)
- Use varied formatting (lists, examples, problems)
- Include interactive elements (practice)
- End with a summary and next steps

---

## Resources for Content Creators

### Free Educational Resources

- Khan Academy (content ideas and structure)
- OpenStax (textbooks)
- Wikipedia (basic information, verify facts)
- Educational YouTube transcripts

### Content Creation Tools

- Text editor (nano, vim, VS Code, Notepad++)
- Spell checker
- Markdown preview (for planning)
- Terminal emulator (for testing)

### Collaboration

- Share content with other teachers
- Get feedback from students
- Iterate based on usage
- Build a content library together

---

## Sample Content Repository Structure

```
materials/
├── mathematics/
│   ├── lessons/
│   │   ├── 01_counting_basics.txt
│   │   ├── 02_addition_subtraction.txt
│   │   ├── 03_multiplication.txt
│   │   ├── 04_division.txt
│   │   ├── 05_fractions.txt
│   │   ├── 06_decimals.txt
│   │   └── ...
│   └── resources/
│       ├── times_tables.txt
│       └── formula_sheet.txt
├── science/
│   ├── lessons/
│   │   ├── 01_scientific_method.txt
│   │   ├── 02_water_cycle.txt
│   │   ├── 03_photosynthesis.txt
│   │   └── ...
│   └── resources/
└── ...
```

---

## Getting Started Checklist

For new content creators:

1. [ ] Read this guide completely
2. [ ] Review existing sample lessons
3. [ ] Choose a subject and topic
4. [ ] Draft content using template
5. [ ] Test in EduShare interface
6. [ ] Get feedback from peers/students
7. [ ] Revise and finalize
8. [ ] Add to repository
9. [ ] Share with other educators!

---

## Support and Questions

For help creating content:
- Review existing lessons in `materials/` directory
- Test frequently in the interface
- Get feedback from students
- Collaborate with other teachers

---

**Happy content creating! Your work makes education accessible to all.**
