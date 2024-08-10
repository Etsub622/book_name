/* eslint-disable prettier/prettier */
import { Body, Controller, Delete, Get, Param, Post, Put, Req, UseGuards } from '@nestjs/common';
import { BookService } from './book.service';
import { Book } from './schemas/book.schema';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { AuthGuard } from '@nestjs/passport';

@Controller('book')
export class BookController {
    constructor(private bookService:BookService){}

    @Get()
    async getAllBooks():Promise<Book[]>{
        return this.bookService.getAllBooks();
    }

    @Get(':/id')
    async getBooById(@Param('id') id:string):Promise<Book>{
        return this.bookService.getBookById(id);}

    @UseGuards(AuthGuard())
    @Post()
    async createNewBook(
        @Body() createBookDto:CreateBookDto,
        @Req()req):Promise<Book>{
        return this.bookService.createNewBook(createBookDto,req.user); }
        
    @Put(':/id')
    async updateBookById(@Param('id') id:string,@Body()updateBookDto:UpdateBookDto):Promise<Book>{
        return this.bookService.updateBookById(id,updateBookDto);}
    
    @Delete(':/id') 
    async deleteById(@Param('id') id:string):Promise<void>{
       return this.bookService.deleteById(id) 
    }  
}


