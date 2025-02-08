/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from "src/auth/schemas/auth.schema";

export enum Category{
    'travel' = 'travel',
    'comedy' = 'comedy',
    'romance' = 'romance',
    'fantasy' = 'fantasy',
    'crime' = 'crime',
    'psychology'= 'psychology',
    'self help' = 'self help',

}


@Schema({timestamps: true})
export class Book{
    
    @Prop()
    title: string;

    @Prop()
    description: string;

    @Prop()
    author: string;

    @Prop()
    price: number;

    @Prop({ type: [String], enum: Category, required: true })
    category: Category[];

    @Prop()
    imageUrl:String[];

    // @Prop({type:mongoose.Schema.Types.ObjectId,ref:'User'})
    // user:User
}

export const BookSchema = SchemaFactory.createForClass(Book);