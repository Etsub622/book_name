/* eslint-disable prettier/prettier */
import {Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Book } from './schemas/book.schema';
import * as mongoose from 'mongoose';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { User } from 'src/auth/schemas/auth.schema';

@Injectable()
export class BookService {
    constructor(
        @InjectModel(Book.name)
        private readonly bookModel:mongoose.Model<Book>
    ){}

    async getAllBooks():Promise<Book[]>{
        const books = await this.bookModel.find();
        return books;}


   async getBookById(id:string):Promise<Book>{
        const book = await this.bookModel.findById(id);
        
        if(!book){
            throw new NotFoundException('Book not found');
        }
        return book;}

    async createNewBook(createBookDto:CreateBookDto,user:User):Promise<Book>{
        const data = Object.assign(createBookDto,{user:user._id})

        const book = await this.bookModel.create(data);
        return book;
    }  

   async updateBookById(id:string,updateBookDto:UpdateBookDto):Promise<Book>{
    return await this.bookModel.findByIdAndUpdate(id,updateBookDto,{new:true,runValidators:true})} 
    
    async deleteById(id:string):Promise<void>{
         await this.bookModel.findByIdAndDelete(id);
    }


 


}
