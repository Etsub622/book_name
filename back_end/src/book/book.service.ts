/* eslint-disable prettier/prettier */
import {BadRequestException, Injectable, InternalServerErrorException, NotFoundException} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Book } from './schemas/book.schema';
import * as mongoose from 'mongoose';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { User } from 'src/auth/schemas/auth.schema';
import { query } from 'express';
import { Query } from 'express-serve-static-core';

@Injectable()
export class BookService {
    constructor(
        @InjectModel(Book.name)
        private readonly bookModel:mongoose.Model<Book>
    ){}

    async getAllBooks(query:Query):Promise<Book[]>{
        // const resperPage = 4;
        // const currentPage = Number(query.page) || 1
        // const skip = resperPage * (currentPage-1);
        // const books = await this.bookModel.find(filter).limit(resperPage).skip(skip).exec();


        const filter:any = {};
        if(query.keyword){
            filter.$or = [
                {
                title:{$regex:query.keyword,$options:'i',},
                description:{$regex:query.keyword,$options:'i',}}];
        }
       

        const books = await this.bookModel.find(filter).exec();
        return books;}




   async getBookById(id:string):Promise<Book>{
        
        const isValid = mongoose.isValidObjectId(id);
        if(!isValid){
            throw new BadRequestException('please enter a valid id');
        }

        const book = await this.bookModel.findById(id);
        if(!book){
            throw new NotFoundException('Book not found');
        }
        return book;}


    async createNewBook(createBookDto: CreateBookDto): Promise<Book> {
    try {
        const res = await this.bookModel.create(createBookDto);
        return res;
    } catch (error) {
        
        throw new InternalServerErrorException('Internal server error');
    }
}

   async updateBookById(id:string,updateBookDto:UpdateBookDto):Promise<Book>{
    return await this.bookModel.findByIdAndUpdate(id,updateBookDto,{new:true,runValidators:true})} 
    
    
    async deleteById(id:string):Promise<void>{
         await this.bookModel.findByIdAndDelete(id);
    }

    async getBookByCategory(category:string):Promise<Book[]>{
        const books = await this.bookModel.find({category:category});
        return books;
    }
}
