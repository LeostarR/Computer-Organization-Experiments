# Computer-Organization-Experiments

Welcome to the repository for the Computer Organization Experiments. This project encompasses a series of assignments and experiments aimed at understanding computer architecture and design through hands-on projects.

#### How to Use

To facilitate the understanding and completion of these projects, several tools are required. Below is a guide on how to download and use these tools:

- **Logisim**
   Logisim is a free software used for designing and simulating digital logic circuits. You can download it from [Logisim's official website](https://sourceforge.net/projects/circuit/?spm=5176.28103460.0.0.297c5d27EQG5Vm). Follow the installation instructions provided on the site.
- **ISE (Integrated Synthesis Environment)**
   ISE is a development tool by Xilinx used for designing and testing Verilog or VHDL code. It can be downloaded from [Xilinx's official website](https://www.xilinx.com/downloadNav/vivado-design-tools/archive-ise.html). Make sure to select the appropriate version for your operating system and follow the installation guide.
- **MARS (MIPS Assembler and Runtime Simulator)**
   MARS is an emulator that allows you to write and run MIPS assembly language programs. You can download MARS from [the official MARS page](http://courses.missouristate.edu/kenvollmar/mars/download.htm?spm=5176.28103460.0.0.297c5d27EQG5Vm). Once installed, you can write MIPS assembly code in the editor, assemble it into machine code, and execute it within the simulator.

Once you have all the necessary tools set up, you can proceed with the following steps to integrate assembly programs with Verilog files:

1. Write your MIPS assembly program in MARS.
2. Use MARS to assemble the program into machine code (bytecode).
3. Export the bytecode as a memory initialization file (.mif) or similar format.
4. Include this file in the Verilog project as part of the memory initialization process.
5. Run the simulation in the Verilog environment to test the functionality of the integrated assembly program.

#### Projects Overview

The Computer-Organization-Experiments include a total of 8 projects (from P0 to P7), covering both theoretical learning and practical applications, all of which have been completed by me.

- **P0: Introduction to Tools**
   Familiarization with Logisim, an essential tool for designing circuits, along with the basics of modules and state machines.
   *(Homework: Constructed CRC check code calculation circuit, ALU, GRF, regular expression matching; Lab: Completed component and FSM design in Logisim)*
- **P1: First Steps with Verilog**
   Getting acquainted with Verilog HDL and learning how to write testbenches and perform simulation tests on ISE.
   *(Homework: Implemented splitter, ALU, EXT, Gray code counter, valid expression recognizer; Lab: Completed component and FSM design using Verilog-HDL)*
- **P2: Exploring MIPS Assembly Language**
   Learning the MIPS assembly language and writing assembly programs.
   *(Homework: Implemented matrix multiplication, palindrome string checking, convolution operations; Lab: Programming exercises)*
- **P3: Single-cycle CPU Design with Logisim**
   Designed a single-cycle CPU supporting 8 instructions using Logisim.
   *(Lab: *Custom instruction additions tested*)*
- **P4: Single-cycle CPU Design with Verilog**
   Developed a single-cycle CPU supporting 10 instructions using Verilog.
   *(Lab: *Custom instruction additions tested*)*
- **P5: Pipelined CPU Design with Verilog**
   Developed a pipelined CPU supporting 10 instructions using Verilog.
   *(Lab: *Custom instruction additions tested*)*
- **P6: Advanced Pipelined CPU Design with Verilog**
   Created a more complex pipelined CPU supporting over 30 instructions using Verilog.
   *(Lab: *Custom instruction additions tested*)*
- **P7: Micro MIPS System Design**
   Finalized the design of a miniature MIPS system with simple I/O development and interrupt verification using Verilog.

----

欢迎来到计算机组成实验的仓库。此项目包含了一系列旨在通过动手实践来理解计算机架构和设计的作业与实验。

#### 项目概览

计组试验一共包含了9次project（从P0到P8），涵盖了理论学习和实践应用，本人完成了从P0到P7课下作业和课上实践的所有内容。

- **P0: 工具入门**
   熟悉用于电路设计的重要工具Logisim，并了解模块及状态机的基础知识。
   *(课下作业：搭建CRC校验码计算电路、ALU、GRF、正则表达式匹配；课上实验：在Logisim中完成部件及FSM设计)*
- **P1: Verilog初体验**
   掌握Verilog硬件描述语言，并学习如何在ISE上编写测试平台以及进行仿真测试。
   *(课下作业：实现splitter、ALU、EXT、格雷码计数器、合法表达式识别；课上实验：使用Verilog-HDL完成部件及FSM设计)*
- **P2: MIPS汇编语言探索**
   学习MIPS汇编语言并能够编写汇编程序。
   *(课下作业：实现矩阵乘法、回文串判断、卷积运算；课上实验：编程题)*
- **P3: 单周期CPU设计（Logisim）**
   使用Logisim“画出”支持8条指令的单周期CPU设计。
   *(课上测试：新增自定义指令测试)*
- **P4: 单周期CPU设计（Verilog）**
   使用Verilog开发完成支持10条指令的单周期CPU设计。
   *(课上测试：新增自定义指令测试)*
- **P5: 流水线CPU设计（Verilog）**
   使用Verilog开发完成支持10条指令的流水线CPU设计。
   *(课上测试：新增自定义指令测试)*
- **P6: 高级流水线CPU设计（Verilog）**
   使用Verilog开发完成支持30条指令的更复杂的流水线CPU设计。
   *(课上测试：新增自定义指令测试)*
- **P7: 微型MIPS系统设计**
   使用Verilog完成微型MIPS系统设计，开发简单I/O，并验证中断。
