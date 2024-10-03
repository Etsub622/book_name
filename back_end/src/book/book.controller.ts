/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { BookService } from './book.service';
import { Book } from './schemas/book.schema';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { AuthGuard } from '@nestjs/passport';
import {Query as ExpressQuery} from 'express-serve-static-core';

@Controller('book')
export class BookController {
    constructor(private bookService:BookService){}

    @Get()
    async getAllBooks( @Query() query:ExpressQuery):Promise<Book[]>{
        return this.bookService.getAllBooks(query);
    }

    @Get(':id')
    async getBooById(@Param('id') id:string):Promise<Book>{
        return this.bookService.getBookById(id);}

    @UseGuards(AuthGuard())
    @Post('create')
    async createNewBook(
        @Body() createBookDto:CreateBookDto
       ):Promise<Book>{

        return this.bookService.createNewBook(createBookDto); }
        
    @Put(':/id')
    async updateBookById(@Param('id') id:string,@Body()updateBookDto:UpdateBookDto):Promise<Book>{
        return this.bookService.updateBookById(id,updateBookDto);}

    @Get('category/:category')  
    async getBookByCategory(@Param('category') category:string):Promise<Book[]>{
        return this.bookService.getBookByCategory(category);
    }  
    
    @Delete(':/id') 
    async deleteById(@Param('id') id:string):Promise<void>{
       return this.bookService.deleteById(id) 
    }  
}


