/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { BookService } from './book.service';
import { BookController } from './book.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Book, BookSchema } from './schemas/book.schema';
import { AuthModule } from '../auth/auth.module';


@Module({
  imports:[
    AuthModule,
    MongooseModule.forFeature([{ name: Book.name, schema: BookSchema }]),
 
  ],
  providers: [BookService],
  controllers: [BookController],
})
export class BookModule {}