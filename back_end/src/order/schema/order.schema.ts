import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Types } from "mongoose";
import { Document } from "mongoose";

@Schema({timestamps:true})
export class Order extends Document{
    @Prop({required: true,type:Types.ObjectId,ref:'Book'})
    bookId: string;

    @Prop()
    bookName: string;

    @Prop()
    bookPrice: number;

    @Prop()
    txRef: string;

    @Prop({default:'pending'})
    paymentStatus: string;

}

export const OrderSchema = SchemaFactory.createForClass(Order);